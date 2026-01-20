import '../models/word_card.dart';
import '../models/word_deck.dart';
import '../../core/utils/result.dart';

/// Abstract repository interface for word operations
abstract class WordRepository {
  /// Initialize the repository
  Future<Result<void>> init();

  /// Get all words
  Future<Result<List<WordCard>>> getAllWords();

  /// Get words for study session (unknown or needs review), optionally filtered by deck
  Future<Result<List<WordCard>>> getWordsForStudy({WordDeck? deck});

  /// Get known words
  Future<Result<List<WordCard>>> getKnownWords();

  /// Get words that need review
  Future<Result<List<WordCard>>> getWordsNeedingReview();

  /// Get new words
  Future<Result<List<WordCard>>> getNewWords();

  /// Get learning words
  Future<Result<List<WordCard>>> getLearningWords();

  /// Get mastered words
  Future<Result<List<WordCard>>> getMasteredWords();

  /// Get unknown words
  Future<Result<List<WordCard>>> getUnknownWords();

  /// Get a word by ID
  Future<Result<WordCard?>> getWordById(int id);

  /// Add a new word
  Future<Result<void>> addWord(WordCard word);

  /// Add multiple words
  Future<Result<void>> addWords(List<WordCard> words);

  /// Update a word
  Future<Result<void>> updateWord(WordCard word);

  /// Delete a word
  Future<Result<void>> deleteWord(int id);

  /// Get statistics
  Future<Result<WordStats>> getStats();

  /// Get statistics for a specific deck
  Future<Result<WordStats>> getDeckStats(WordDeck? deck);

  /// Mark word as known
  Future<Result<void>> markWordAsKnown(int id);

  /// Mark word for review
  Future<Result<void>> markWordForReview(int id);

  /// Get words for a specific deck
  Future<Result<List<WordCard>>> getWordsByDeck(WordDeck deck);

  /// Reset learning progress
  Future<Result<void>> resetProgress();

  /// Save custom word
  Future<Result<void>> saveCustomWord(WordCard word);

  /// Delete custom word
  Future<Result<void>> deleteCustomWord(int id);

  /// Get custom deck names
  Result<List<String>> getCustomDeckNames();

  /// Get deck counts
  Result<Map<WordDeck, int>> getAllDeckCounts();
}

/// Statistics about word learning progress
class WordStats {
  final int totalWords;
  final int knownWords; // Legacy: srsLevel >= 1 (for backward compatibility)
  final int reviewWords; // Words due for review
  final int newWords; // Never studied words
  final int learningWords; // Words with srsLevel 1-5 (in progress)
  final int masteredWords; // Words with srsLevel 6+ (fully learned)
  final int unknownWords; // Words studied but always marked unknown

  WordStats({
    required this.totalWords,
    required this.knownWords,
    required this.reviewWords,
    required this.newWords,
    this.learningWords = 0,
    this.masteredWords = 0,
    this.unknownWords = 0,
  });

  double get progressPercentage =>
      totalWords > 0 ? (knownWords / totalWords) * 100 : 0;
}
