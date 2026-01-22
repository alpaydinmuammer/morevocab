import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum for game types
enum ArcadeGameType { wordChain, anagram, wordBuilder, emojiPuzzle, oddOneOut }

/// Arcade state including high scores and level progress
class ArcadeState {
  final Map<ArcadeGameType, int> scores;
  final Map<ArcadeGameType, int> levelProgress;

  const ArcadeState({this.scores = const {}, this.levelProgress = const {}});

  int getScore(ArcadeGameType game) => scores[game] ?? 0;
  int getLevel(ArcadeGameType game) => levelProgress[game] ?? 0;

  ArcadeState copyWith({
    Map<ArcadeGameType, int>? scores,
    Map<ArcadeGameType, int>? levelProgress,
  }) {
    return ArcadeState(
      scores: scores ?? this.scores,
      levelProgress: levelProgress ?? this.levelProgress,
    );
  }
}

/// Arcade state notifier
class ArcadeStateNotifier extends StateNotifier<ArcadeState> {
  ArcadeStateNotifier() : super(const ArcadeState()) {
    _loadState();
  }

  static const _scorePrefix = 'arcade_highscore_';
  static const _levelPrefix = 'arcade_level_';

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = <ArcadeGameType, int>{};
    final levels = <ArcadeGameType, int>{};

    for (final game in ArcadeGameType.values) {
      scores[game] = prefs.getInt('$_scorePrefix${game.name}') ?? 0;
      levels[game] = prefs.getInt('$_levelPrefix${game.name}') ?? 0;
    }

    state = ArcadeState(scores: scores, levelProgress: levels);
  }

  Future<void> updateScore(ArcadeGameType game, int score) async {
    final currentHigh = state.getScore(game);
    if (score > currentHigh) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('$_scorePrefix${game.name}', score);

      final newScores = Map<ArcadeGameType, int>.from(state.scores);
      newScores[game] = score;
      state = state.copyWith(scores: newScores);
    }
  }

  Future<void> updateLevel(ArcadeGameType game, int level) async {
    final currentLevel = state.getLevel(game);
    if (level > currentLevel) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('$_levelPrefix${game.name}', level);

      final newLevels = Map<ArcadeGameType, int>.from(state.levelProgress);
      newLevels[game] = level;
      state = state.copyWith(levelProgress: newLevels);
    }
  }

  int getHighScore(ArcadeGameType game) => state.getScore(game);
  int getLevel(ArcadeGameType game) => state.getLevel(game);
}

/// Provider for arcade state (high scores + level progress)
final arcadeHighScoresProvider =
    StateNotifierProvider<ArcadeStateNotifier, ArcadeState>(
      (ref) => ArcadeStateNotifier(),
    );
