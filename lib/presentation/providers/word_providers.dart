import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../domain/models/word_card.dart';
import '../../domain/models/word_deck.dart';
import '../../domain/repositories/word_repository.dart';
import '../../data/repositories/word_repository_impl.dart';

import 'settings_provider.dart';

/// Provider for the word repository
final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepositoryImpl();
});

/// Provider for TTS engine
final ttsProvider = Provider<FlutterTts>((ref) {
  final settings = ref.watch(settingsProvider);
  final tts = FlutterTts();

  tts.setLanguage('en-US');
  tts.setSpeechRate(settings.ttsRate);
  tts.setVolume(settings.ttsVolume);
  tts.setPitch(settings.ttsPitch);

  return tts;
});

/// Provider for selected deck
final selectedDeckProvider = StateProvider<WordDeck>((ref) => WordDeck.mixed);

/// State for the word study session
class WordStudyState {
  final List<WordCard> words;
  final int currentIndex;
  final bool isLoading;
  final String? error;
  final int sessionKnownCount;
  final int sessionReviewCount;
  final WordDeck currentDeck;

  const WordStudyState({
    this.words = const [],
    this.currentIndex = 0,
    this.isLoading = true,
    this.error,
    this.sessionKnownCount = 0,
    this.sessionReviewCount = 0,
    this.currentDeck = WordDeck.mixed,
  });

  WordStudyState copyWith({
    List<WordCard>? words,
    int? currentIndex,
    bool? isLoading,
    String? error,
    int? sessionKnownCount,
    int? sessionReviewCount,
    WordDeck? currentDeck,
  }) {
    return WordStudyState(
      words: words ?? this.words,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sessionKnownCount: sessionKnownCount ?? this.sessionKnownCount,
      sessionReviewCount: sessionReviewCount ?? this.sessionReviewCount,
      currentDeck: currentDeck ?? this.currentDeck,
    );
  }

  bool get hasMoreCards => currentIndex < words.length;
  WordCard? get currentCard => hasMoreCards ? words[currentIndex] : null;
  int get remainingCards => words.length - currentIndex;
  bool get isSessionComplete => !hasMoreCards && !isLoading;
}

/// Notifier for managing word study session
class WordStudyNotifier extends StateNotifier<WordStudyState> {
  final WordRepository _repository;

  WordStudyNotifier(this._repository) : super(const WordStudyState()) {
    loadWords();
  }

  Future<void> loadWords([WordDeck? deck]) async {
    final selectedDeck = deck ?? state.currentDeck;
    state = state.copyWith(
      isLoading: true,
      error: null,
      currentDeck: selectedDeck,
    );

    final result = await _repository.getWordsForStudy(deck: selectedDeck);
    result.when(
      success: (words) {
        words.shuffle();
        state = state.copyWith(
          words: words,
          currentIndex: 0,
          isLoading: false,
          sessionKnownCount: 0,
          sessionReviewCount: 0,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error);
      },
    );
  }

  Future<void> markCurrentAsKnown() async {
    final card = state.currentCard;
    if (card == null) return;

    final result = await _repository.markWordAsKnown(card.id);
    result.when(
      success: (_) {
        state = state.copyWith(
          currentIndex: state.currentIndex + 1,
          sessionKnownCount: state.sessionKnownCount + 1,
        );
      },
      failure: (error) {
        state = state.copyWith(error: error);
      },
    );
  }

  Future<void> markCurrentForReview() async {
    final card = state.currentCard;
    if (card == null) return;

    final result = await _repository.markWordForReview(card.id);
    result.when(
      success: (_) {
        state = state.copyWith(
          currentIndex: state.currentIndex + 1,
          sessionReviewCount: state.sessionReviewCount + 1,
        );
      },
      failure: (error) {
        state = state.copyWith(error: error);
      },
    );
  }

  void reset() {
    loadWords();
  }
}

/// Provider for the word study notifier
final wordStudyProvider =
    StateNotifierProvider<WordStudyNotifier, WordStudyState>((ref) {
      final repository = ref.watch(wordRepositoryProvider);
      return WordStudyNotifier(repository);
    });

/// Provider for word statistics
final wordStatsProvider = FutureProvider<WordStats>((ref) async {
  final repository = ref.watch(wordRepositoryProvider);
  final result = await repository.getStats();
  return result.when(
    success: (stats) => stats,
    failure: (error) => throw Exception(error),
  );
});

/// Provider for deck statistics
final deckStatsProvider = FutureProvider.family<WordStats, WordDeck?>((
  ref,
  deck,
) async {
  final repository = ref.watch(wordRepositoryProvider);
  final result = await repository.getDeckStats(deck);
  return result.when(
    success: (stats) => stats,
    failure: (error) => throw Exception(error),
  );
});
