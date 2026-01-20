import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/word_card.dart';
import '../../domain/models/word_deck.dart';
import '../../core/exceptions/app_exceptions.dart';

/// Word storage with persistent progress using SharedPreferences
/// Uses dependency injection for better testability.
class WordLocalDatasource {
  WordLocalDatasource({SharedPreferences? prefs}) : _prefs = prefs;

  static const String _progressKey = 'word_progress';
  static const String _customWordsKey = 'custom_words_data';

  final List<WordCard> _words = [];
  SharedPreferences? _prefs;
  bool _initialized = false;

  /// Singleton instance for production use
  static WordLocalDatasource? _instance;

  /// Get the singleton instance (creates one if needed)
  static WordLocalDatasource get instance {
    _instance ??= WordLocalDatasource();
    return _instance!;
  }

  /// Set a custom instance (useful for testing)
  static void setInstance(WordLocalDatasource datasource) {
    _instance = datasource;
  }

  /// Reset the singleton (useful for testing)
  static void resetInstance() {
    _instance = null;
  }

  /// Initialize the datasource asynchronously.
  /// Must be called before accessing data.
  Future<void> init() async {
    if (_initialized) return;

    _prefs = await SharedPreferences.getInstance();

    // Load words from JSON assets
    await _loadWordsFromJson();

    // Load custom user words
    await _loadCustomWords();

    // Load saved progress
    await _loadProgress();

    _initialized = true;
    debugPrint('WordLocalDatasource initialized with ${_words.length} words.');
  }

  /// Load words from asset JSON files
  /// Throws [DataLoadException] if loading fails critically
  Future<void> _loadWordsFromJson() async {
    if (_words.isNotEmpty) return;

    final files = [
      'assets/data/words_common.json',
      'assets/data/words_yds.json',
      'assets/data/words_beginner.json',
      'assets/data/words_survival.json',
      'assets/data/words_phrasal.json',
      'assets/data/words_idioms.json',
      'assets/data/words_exam.json',
    ];

    int loadedCount = 0;
    final errors = <String>[];

    for (final file in files) {
      try {
        final jsonString = await rootBundle.loadString(file);
        final List<dynamic> list = json.decode(jsonString);
        _words.addAll(list.map((e) => WordCard.fromJson(e)).toList());
        loadedCount++;
        // Yield to main thread to allow UI to update
        await Future.delayed(Duration.zero);
      } catch (e) {
        errors.add('$file: $e');
        debugPrint('Warning: Failed to load $file: $e');
      }
    }

    // If no files were loaded, throw an exception
    if (loadedCount == 0) {
      throw DataLoadException(
        'Could not load any word files. Errors: ${errors.join(', ')}',
      );
    }

    // Log warnings for partially failed loads
    if (errors.isNotEmpty) {
      debugPrint(
        'Warning: ${errors.length}/${files.length} files failed to load',
      );
    }
  }

  /// Load custom words from SharedPreferences
  /// Logs warning but doesn't throw on failure (custom words are optional)
  Future<void> _loadCustomWords() async {
    if (_prefs == null) return;

    final String? customWordsJson = _prefs!.getString(_customWordsKey);
    if (customWordsJson == null || customWordsJson.isEmpty) return;

    try {
      final List<dynamic> list = json.decode(customWordsJson);
      final List<WordCard> customWords =
          list.map((e) => WordCard.fromJson(e)).toList();

      // Add custom words to the main list, avoiding duplicates
      for (var word in customWords) {
        if (!_words.any((w) => w.id == word.id)) {
          _words.add(word);
        }
      }
      debugPrint('Loaded ${customWords.length} custom words');
    } catch (e) {
      // Custom words are optional, so just log the error
      debugPrint('Warning: Could not load custom words: $e');
    }
  }

  /// Save a new custom word
  /// Throws [DataSaveException] if saving fails
  Future<void> saveCustomWord(WordCard newWord) async {
    if (_prefs == null) {
      throw const DataSaveException('SharedPreferences not initialized');
    }

    // Add to in-memory list
    _words.add(newWord);

    // Persist to storage
    try {
      await _saveCustomWordsToPrefs();
    } catch (e) {
      // Rollback in-memory change on failure
      _words.removeWhere((w) => w.id == newWord.id);
      throw DataSaveException(e.toString());
    }
  }

  /// Delete a custom word
  Future<void> deleteCustomWord(int id) async {
    _words.removeWhere((w) => w.id == id && w.deck == WordDeck.custom);
    await _saveCustomWordsToPrefs();
    // Also clean up progress for this word to stay clean
    await _cleanProgressForDeletedWord(id);
  }

  /// Helper to write all custom words to prefs
  Future<void> _saveCustomWordsToPrefs() async {
    if (_prefs == null) return;

    final customWords = _words.where((w) => w.deck == WordDeck.custom).toList();
    final String jsonString = json.encode(
      customWords.map((e) => e.toJson()).toList(),
    );

    await _prefs!.setString(_customWordsKey, jsonString);
  }

  /// Clean up progress map for a deleted word
  Future<void> _cleanProgressForDeletedWord(int id) async {
    if (_prefs == null) return;

    final String? progressJson = _prefs!.getString(_progressKey);
    if (progressJson == null) return;

    try {
      final Map<String, dynamic> progressMap = json.decode(progressJson);
      if (progressMap.containsKey(id.toString())) {
        progressMap.remove(id.toString());
        await _prefs!.setString(_progressKey, json.encode(progressMap));
      }
    } catch (e) {
      debugPrint('Error cleaning progress: $e');
    }
  }

  /// Get list of unique custom deck names
  List<String> getCustomDeckNames() {
    return _words
        .where((w) => w.deck == WordDeck.custom && w.customDeckName != null)
        .map((w) => w.customDeckName!)
        .toSet()
        .toList();
  }

  /// Load user progress from SharedPreferences
  Future<void> _loadProgress() async {
    if (_prefs == null) return;

    final String? progressJson = _prefs!.getString(_progressKey);
    if (progressJson == null) return;

    try {
      final Map<String, dynamic> progressMap = json.decode(progressJson);

      for (int i = 0; i < _words.length; i++) {
        final WordCard word = _words[i];
        final String idStr = word.id.toString();

        if (progressMap.containsKey(idStr)) {
          final Map<String, dynamic> data = progressMap[idStr];

          _words[i] = _words[i].copyWith(
            isKnown: data['isKnown'] ?? false,
            needsReview: data['needsReview'] ?? false,
            lastReviewDate: data['lastReviewDate'] != null
                ? DateTime.parse(data['lastReviewDate'])
                : null,
            reviewCount: data['reviewCount'] ?? 0,
            srsLevel: data['srsLevel'] ?? 0,
            nextReviewDate: data['nextReviewDate'] != null
                ? DateTime.parse(data['nextReviewDate'])
                : null,
            consecutiveCorrect: data['consecutiveCorrect'] ?? 0,
          );
        }
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
    }
  }

  /// Save progress for a specific word
  Future<void> _saveProgress() async {
    if (_prefs == null) return;

    final Map<String, dynamic> progressMap = {};

    for (var word in _words) {
      // Only save words that have some progress to minimize storage
      if (word.reviewCount > 0 ||
          word.isKnown ||
          word.srsLevel > 0 ||
          word.needsReview) {
        progressMap[word.id.toString()] = {
          'isKnown': word.isKnown,
          'needsReview': word.needsReview,
          'lastReviewDate': word.lastReviewDate?.toIso8601String(),
          'reviewCount': word.reviewCount,
          'srsLevel': word.srsLevel,
          'nextReviewDate': word.nextReviewDate?.toIso8601String(),
          'consecutiveCorrect': word.consecutiveCorrect,
        };
      }
    }

    await _prefs!.setString(_progressKey, json.encode(progressMap));
  }

  /// Public API to update progress for a single word
  Future<void> updateProgress(WordCard updatedWord) async {
    final int index = _words.indexWhere((w) => w.id == updatedWord.id);
    if (index != -1) {
      _words[index] = updatedWord;
      await _saveProgress();
    }
  }

  /// Get all words (immutable view preferable, but returning list copy)
  List<WordCard> getWords() {
    return List.from(_words);
  }

  /// Get words by deck/category
  List<WordCard> getWordsByDeck(WordDeck deck) {
    if (deck == WordDeck.mixed) {
      return List.from(_words);
    }
    return _words.where((w) => w.deck == deck).toList();
  }

  /// Get word count by deck
  int getWordCountByDeck(WordDeck deck) {
    if (deck == WordDeck.mixed) {
      return _words.length;
    }
    return _words.where((w) => w.deck == deck).length;
  }

  /// Get all words (Restored method)
  List<WordCard> getAllWords() {
    return List.from(_words);
  }

  /// Get word by ID (Restored method)
  WordCard? getWordById(int id) {
    try {
      return _words.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Update a word (Restored method - alias for updateProgress)
  Future<void> updateWord(WordCard word) async {
    await updateProgress(word);
  }

  /// Get counts for all decks (Restored method)
  Map<WordDeck, int> getAllDeckCounts() {
    final Map<WordDeck, int> counts = {};
    for (var deck in WordDeck.values) {
      counts[deck] = getWordCountByDeck(deck);
    }
    return counts;
  }

  // ===========================================================================
  // Filter Methods (Restored for Repository)
  // ===========================================================================

  List<WordCard> getKnownWords() {
    return _words.where((w) => w.isKnown).toList();
  }

  List<WordCard> getWordsNeedingReview() {
    // Return words that literally have needsReview flag or are due by SRS
    return _words.where((w) => w.needsReview || w.isDueForReview).toList();
  }

  List<WordCard> getNewWords() {
    return _words.where((w) => w.reviewCount == 0 && !w.isKnown).toList();
  }

  List<WordCard> getLearningWords() {
    return _words
        .where(
          (w) =>
              w.reviewCount > 0 &&
              !w.isKnown &&
              !w.isMastered &&
              w.srsLevel > 0,
        )
        .toList();
  }

  List<WordCard> getMasteredWords() {
    return _words.where((w) => w.isMastered).toList();
  }

  List<WordCard> getUnknownWords() {
    return _words.where((w) => !w.isKnown).toList();
  }

  /// Words eligible for study session (New + Review + Learning)
  List<WordCard> getWordsForStudy() {
    return _words
        .where((w) => !w.isKnown || w.isDueForReview || w.needsReview)
        .toList();
  }

  // ===========================================================================
  // Count Methods (Restored for Repository)
  // ===========================================================================

  int getWordCount() => _words.length;
  int getKnownWordCount() => getKnownWords().length;
  int getReviewWordCount() => getWordsNeedingReview().length;
  int getNewWordCount() => getNewWords().length;
  int getLearningWordCount() => getLearningWords().length;
  int getMasteredWordCount() => getMasteredWords().length;
  int getUnknownWordCount() => getUnknownWords().length;

  /// Reset all progress
  Future<void> resetProgress() async {
    for (int i = 0; i < _words.length; i++) {
      _words[i] = _words[i].copyWith(
        isKnown: false,
        needsReview: false,
        lastReviewDate: null,
        reviewCount: 0,
        srsLevel: 0,
        nextReviewDate: null,
        consecutiveCorrect: 0,
      );
    }
    if (_prefs != null) {
      await _prefs!.remove(_progressKey);
    }
  }
}
