import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';

/// Enum for game types
enum ArcadeGameType { wordChain, anagram, wordBuilder, emojiPuzzle, oddOneOut }

/// Arcade state including high scores and level progress
class ArcadeState {
  final Map<ArcadeGameType, int> scores;
  final Map<ArcadeGameType, int> levelProgress;
  final Map<ArcadeGameType, List<String>>
  currentLevelWords; // Persisted progress

  const ArcadeState({
    this.scores = const {},
    this.levelProgress = const {},
    this.currentLevelWords = const {},
  });

  int getScore(ArcadeGameType game) => scores[game] ?? 0;
  int getLevel(ArcadeGameType game) => levelProgress[game] ?? 0;
  List<String> getLevelWords(ArcadeGameType game) =>
      currentLevelWords[game] ?? [];

  ArcadeState copyWith({
    Map<ArcadeGameType, int>? scores,
    Map<ArcadeGameType, int>? levelProgress,
    Map<ArcadeGameType, List<String>>? currentLevelWords,
  }) {
    return ArcadeState(
      scores: scores ?? this.scores,
      levelProgress: levelProgress ?? this.levelProgress,
      currentLevelWords: currentLevelWords ?? this.currentLevelWords,
    );
  }
}

/// Arcade state notifier
class ArcadeStateNotifier extends StateNotifier<ArcadeState> {
  ArcadeStateNotifier() : super(const ArcadeState()) {
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = <ArcadeGameType, int>{};
    final levels = <ArcadeGameType, int>{};
    final progress = <ArcadeGameType, List<String>>{};

    for (final game in ArcadeGameType.values) {
      scores[game] = prefs.getInt('${StorageKeys.arcadeHighscorePrefix}${game.name}') ?? 0;
      levels[game] = prefs.getInt('${StorageKeys.arcadeLevelPrefix}${game.name}') ?? 0;
      progress[game] =
          prefs.getStringList('${StorageKeys.arcadeProgressPrefix}${game.name}') ?? [];
    }

    state = ArcadeState(
      scores: scores,
      levelProgress: levels,
      currentLevelWords: progress,
    );
  }

  Future<void> updateScore(ArcadeGameType game, int score) async {
    final currentHigh = state.getScore(game);
    if (score > currentHigh) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('${StorageKeys.arcadeHighscorePrefix}${game.name}', score);

      final newScores = Map<ArcadeGameType, int>.from(state.scores);
      newScores[game] = score;
      state = state.copyWith(scores: newScores);
    }
  }

  Future<void> updateLevel(ArcadeGameType game, int level) async {
    final currentLevel = state.getLevel(game);
    // Even if level isn't higher (e.g. replaying), we might want to set it?
    // But usually updateLevel is called when Level Complete.
    // If we complete a level, we should definitely clear the progress for that type.

    final prefs = await SharedPreferences.getInstance();

    // 1. Update LeveL
    if (level > currentLevel) {
      await prefs.setInt('${StorageKeys.arcadeLevelPrefix}${game.name}', level);
      final newLevels = Map<ArcadeGameType, int>.from(state.levelProgress);
      newLevels[game] = level;
      // We will perform the copyWith at the end combine changes
      state = state.copyWith(levelProgress: newLevels);
    }

    // 2. Clear Progress (New level started or completed)
    // When leveling up, the "found words" for the old level are irrelevant.
    await prefs.remove('${StorageKeys.arcadeProgressPrefix}${game.name}');
    final newProgress = Map<ArcadeGameType, List<String>>.from(
      state.currentLevelWords,
    );
    newProgress[game] = [];
    state = state.copyWith(currentLevelWords: newProgress);
  }

  Future<void> saveLevelProgress(
    ArcadeGameType game,
    List<String> words,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${StorageKeys.arcadeProgressPrefix}${game.name}', words);

    final newProgress = Map<ArcadeGameType, List<String>>.from(
      state.currentLevelWords,
    );
    newProgress[game] = words;
    state = state.copyWith(currentLevelWords: newProgress);
  }

  int getHighScore(ArcadeGameType game) => state.getScore(game);
  int getLevel(ArcadeGameType game) => state.getLevel(game);
  List<String> getLevelWords(ArcadeGameType game) => state.getLevelWords(game);
}

/// Provider for arcade state (high scores + level progress)
final arcadeHighScoresProvider =
    StateNotifierProvider<ArcadeStateNotifier, ArcadeState>(
      (ref) => ArcadeStateNotifier(),
    );
