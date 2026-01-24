import '../../domain/models/word_card.dart';
import '../../domain/models/word_deck.dart';
import '../../domain/repositories/word_repository.dart';
import '../datasources/word_local_datasource.dart';
import '../../core/utils/result.dart';

/// Implementation of WordRepository using in-memory storage with persistence
class WordRepositoryImpl implements WordRepository {
  final WordLocalDatasource _datasource;

  /// Create repository with optional custom datasource (useful for testing)
  WordRepositoryImpl({WordLocalDatasource? datasource})
    : _datasource = datasource ?? WordLocalDatasource.instance;

  @override
  Future<Result<void>> init() async {
    try {
      await _datasource.init();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to initialize: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getAllWords() async {
    try {
      return Success(_datasource.getAllWords());
    } catch (e) {
      return Failure('Failed to fetch all words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getWordsForStudy({WordDeck? deck}) async {
    try {
      if (deck != null && deck != WordDeck.mixed) {
        return Success(_datasource.getWordsByDeck(deck));
      }
      return Success(_datasource.getWordsForStudy());
    } catch (e) {
      return Failure('Failed to fetch study words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getKnownWords() async {
    try {
      return Success(_datasource.getKnownWords());
    } catch (e) {
      return Failure('Failed to fetch known words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getWordsNeedingReview() async {
    try {
      return Success(_datasource.getWordsNeedingReview());
    } catch (e) {
      return Failure('Failed to fetch review words: ${e.toString()}');
    }
  }

  @override
  Future<Result<WordCard?>> getWordById(int id) async {
    try {
      return Success(_datasource.getWordById(id));
    } catch (e) {
      return Failure('Failed to fetch word: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getNewWords() async {
    try {
      return Success(_datasource.getNewWords());
    } catch (e) {
      return Failure('Failed to fetch new words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getLearningWords() async {
    try {
      return Success(_datasource.getLearningWords());
    } catch (e) {
      return Failure('Failed to fetch learning words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getMasteredWords() async {
    try {
      return Success(_datasource.getMasteredWords());
    } catch (e) {
      return Failure('Failed to fetch mastered words: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getUnknownWords() async {
    try {
      return Success(_datasource.getUnknownWords());
    } catch (e) {
      return Failure('Failed to fetch unknown words: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> addWord(WordCard word) async {
    try {
      await _datasource.saveCustomWord(word);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to add word: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> addWords(List<WordCard> words) async {
    try {
      for (final word in words) {
        await _datasource.saveCustomWord(word);
      }
      return const Success(null);
    } catch (e) {
      return Failure('Failed to add words: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> updateWord(WordCard word) async {
    try {
      await _datasource.updateWord(word);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to update word: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteWord(int id) async {
    try {
      await _datasource.deleteCustomWord(id);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete word: ${e.toString()}');
    }
  }

  @override
  Future<Result<WordStats>> getStats() async {
    try {
      return Success(_calculateStats(_datasource.getAllWords()));
    } catch (e) {
      return Failure('Failed to calculate stats: ${e.toString()}');
    }
  }

  @override
  Future<Result<WordStats>> getDeckStats(WordDeck? deck) async {
    try {
      if (deck == null || deck == WordDeck.mixed) {
        return Success(
          _calculateStats(_datasource.getWordsByDeck(WordDeck.mixed)),
        );
      }
      return Success(_calculateStats(_datasource.getWordsByDeck(deck)));
    } catch (e) {
      return Failure('Failed to calculate deck stats: ${e.toString()}');
    }
  }

  /// Calculates statistics for a given list of words
  /// Extracted to avoid code duplication between getStats and getDeckStats
  WordStats _calculateStats(List<WordCard> words) {
    final total = words.length;

    final learning = words
        .where(
          (w) =>
              w.reviewCount > 0 &&
              !w.isKnown &&
              !w.isMastered &&
              w.srsLevel > 0,
        )
        .length;
    final mastered = words.where((w) => w.isMastered).length;
    final review = words.where((w) => w.isDueForReview).length;
    final newWords = words.where((w) => w.isNew).length;

    return WordStats(
      totalWords: total,
      knownWords: learning + mastered,
      reviewWords: review,
      newWords: newWords,
      learningWords: learning,
      masteredWords: mastered,
      unknownWords: total - newWords - learning - mastered,
    );
  }

  @override
  Future<Result<void>> markWordAsKnown(int id) async {
    try {
      final word = _datasource.getWordById(id);
      if (word != null) {
        final updatedWord = word.markAsKnown();
        await _datasource.updateWord(updatedWord);
      }
      return const Success(null);
    } catch (e) {
      return Failure('Failed to mark word as known: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> markWordForReview(int id) async {
    try {
      final word = _datasource.getWordById(id);
      if (word != null) {
        final updatedWord = word.markForReview();
        await _datasource.updateWord(updatedWord);
      }
      return const Success(null);
    } catch (e) {
      return Failure('Failed to mark word for review: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<WordCard>>> getWordsByDeck(WordDeck deck) async {
    try {
      return Success(_datasource.getWordsByDeck(deck));
    } catch (e) {
      return Failure('Failed to fetch words by deck: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> resetProgress() async {
    try {
      await _datasource.resetProgress();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to reset progress: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> saveCustomWord(WordCard word) async {
    try {
      await _datasource.saveCustomWord(word);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save custom word: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteCustomWord(int id) async {
    try {
      await _datasource.deleteCustomWord(id);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete custom word: ${e.toString()}');
    }
  }

  @override
  Result<List<String>> getCustomDeckNames() {
    try {
      return Success(_datasource.getCustomDeckNames());
    } catch (e) {
      return Failure('Failed to get custom deck names: ${e.toString()}');
    }
  }

  @override
  Result<Map<WordDeck, int>> getAllDeckCounts() {
    try {
      return Success(_datasource.getAllDeckCounts());
    } catch (e) {
      return Failure('Failed to get deck counts: ${e.toString()}');
    }
  }
}
