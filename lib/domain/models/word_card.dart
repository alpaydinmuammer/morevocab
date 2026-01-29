import '../../core/constants/srs_constants.dart';
import '../services/srs_algorithm.dart';
import 'word_deck.dart';

/// WordCard model for vocabulary learning with SRS support
/// This class is immutable - use copyWith() or marking methods to create new instances
class WordCard {
  final int id;
  final String word;
  final Map<String, String> meanings;
  final String? exampleSentence;
  final List<String>? synonyms;
  final String? imageUrl;
  final String? localAsset;
  final WordDeck deck;
  final String? customDeckName;
  final bool isKnown;
  final bool needsReview;
  final DateTime? lastReviewDate;
  final int reviewCount;
  final int difficulty;

  // SRS (Spaced Repetition System) fields
  final int srsLevel; // 0-6, higher = more learned
  final DateTime? nextReviewDate;
  final int consecutiveCorrect;

  const WordCard({
    required this.id,
    required this.word,
    required this.meanings,
    this.exampleSentence,
    this.synonyms,
    this.imageUrl,
    this.localAsset,
    this.deck = WordDeck.mixed,
    this.customDeckName,
    this.isKnown = false,
    this.needsReview = false,
    this.lastReviewDate,
    this.reviewCount = 0,
    this.difficulty = 1,
    this.srsLevel = 0,
    this.nextReviewDate,
    this.consecutiveCorrect = 0,
  });

  factory WordCard.fromJson(Map<String, dynamic> json) {
    return WordCard(
      id: json['id'] as int,
      word: json['word'] as String,
      meanings: Map<String, String>.from(json['meanings'] as Map),
      exampleSentence: json['exampleSentence'] as String?,
      synonyms: (json['synonyms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String?,
      localAsset: json['localAsset'] as String?,
      difficulty: json['difficulty'] as int,
      deck: WordDeck.values.firstWhere(
        (e) => e.name == json['deck'],
        orElse: () => WordDeck.mixed,
      ),
      customDeckName: json['customDeckName'] as String?,
      // Initialize SRS fields from JSON if available, otherwise use defaults
      isKnown: json['isKnown'] as bool? ?? false,
      needsReview: json['needsReview'] as bool? ?? false,
      lastReviewDate: json['lastReviewDate'] != null
          ? DateTime.parse(json['lastReviewDate'] as String)
          : null,
      reviewCount: json['reviewCount'] as int? ?? 0,
      srsLevel: json['srsLevel'] as int? ?? 0,
      nextReviewDate: json['nextReviewDate'] != null
          ? DateTime.parse(json['nextReviewDate'] as String)
          : null,
      consecutiveCorrect: json['consecutiveCorrect'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'meanings': meanings,
      'exampleSentence': exampleSentence,
      'synonyms': synonyms,
      'imageUrl': imageUrl,
      'localAsset': localAsset,
      'difficulty': difficulty,
      'deck': deck.name,
      'customDeckName': customDeckName,
      'isKnown': isKnown,
      'needsReview': needsReview,
      'lastReviewDate': lastReviewDate?.toIso8601String(),
      'reviewCount': reviewCount,
      'srsLevel': srsLevel,
      'nextReviewDate': nextReviewDate?.toIso8601String(),
      'consecutiveCorrect': consecutiveCorrect,
    };
  }

  /// Get meaning based on language code
  String getMeaning(String languageCode) {
    return meanings[languageCode] ?? meanings['en'] ?? meanings['tr'] ?? '';
  }

  /// Check if this word has a local asset image
  bool get hasLocalAsset => localAsset != null && localAsset!.isNotEmpty;

  /// Check if this word is due for review
  bool get isDueForReview => SrsAlgorithm.isDueForReview(nextReviewDate);

  /// Check if this word is mastered
  bool get isMastered => SrsAlgorithm.isMastered(srsLevel);

  /// Check if this word is new (never reviewed)
  bool get isNew => reviewCount == 0 && srsLevel == 0;

  /// Get the SRS level description
  String get srsLevelDescription => SrsAlgorithm.getLevelDescription(srsLevel);

  /// Days until next review
  int get daysUntilReview => SrsAlgorithm.getDaysUntilReview(nextReviewDate);

  /// Mark this word as known (correct answer) - returns new instance with updated SRS
  WordCard markAsKnown() {
    final newSrsLevel = SrsAlgorithm.getNewLevel(srsLevel, true);
    final isMasteredNow = newSrsLevel >= SrsConstants.maxLevel;

    return copyWith(
      srsLevel: newSrsLevel,
      nextReviewDate: SrsAlgorithm.calculateNextReview(newSrsLevel),
      consecutiveCorrect: consecutiveCorrect + 1,
      lastReviewDate: DateTime.now(),
      reviewCount: reviewCount + 1,
      isKnown: isMasteredNow,
      needsReview: !isMasteredNow,
    );
  }

  /// Mark this word as needing review (wrong answer) - returns new instance with reset SRS
  WordCard markForReview() {
    return copyWith(
      srsLevel: SrsAlgorithm.getNewLevel(srsLevel, false),
      nextReviewDate: SrsAlgorithm.calculateNextReview(0),
      consecutiveCorrect: 0,
      lastReviewDate: DateTime.now(),
      reviewCount: reviewCount + 1,
      isKnown: false,
      needsReview: true,
    );
  }

  WordCard copyWith({
    int? id,
    String? word,
    Map<String, String>? meanings,
    String? exampleSentence,
    List<String>? synonyms,
    String? imageUrl,
    String? localAsset,
    WordDeck? deck,
    String? customDeckName,
    bool? isKnown,
    bool? needsReview,
    DateTime? lastReviewDate,
    int? reviewCount,
    int? difficulty,
    int? srsLevel,
    DateTime? nextReviewDate,
    int? consecutiveCorrect,
  }) {
    return WordCard(
      id: id ?? this.id,
      word: word ?? this.word,
      meanings: meanings ?? this.meanings,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      synonyms: synonyms ?? this.synonyms,
      imageUrl: imageUrl ?? this.imageUrl,
      localAsset: localAsset ?? this.localAsset,
      deck: deck ?? this.deck,
      customDeckName: customDeckName ?? this.customDeckName,
      isKnown: isKnown ?? this.isKnown,
      needsReview: needsReview ?? this.needsReview,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      reviewCount: reviewCount ?? this.reviewCount,
      difficulty: difficulty ?? this.difficulty,
      srsLevel: srsLevel ?? this.srsLevel,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
    );
  }

  @override
  String toString() {
    return 'WordCard(id: $id, word: $word, srsLevel: $srsLevel, isKnown: $isKnown)';
  }
}
