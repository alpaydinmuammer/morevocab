import 'dart:math';
import '../../../presentation/providers/arcade_provider.dart';

/// Represents a daily challenge
class Challenge {
  final String id;
  final ChallengeType type;
  final ArcadeGameType? gameType;
  final int targetValue;
  final int xpReward;
  final int currentProgress;
  final bool isCompleted;

  const Challenge({
    required this.id,
    required this.type,
    this.gameType,
    required this.targetValue,
    required this.xpReward,
    this.currentProgress = 0,
    this.isCompleted = false,
  });

  Challenge copyWith({int? currentProgress, bool? isCompleted}) {
    return Challenge(
      id: id,
      type: type,
      gameType: gameType,
      targetValue: targetValue,
      xpReward: xpReward,
      currentProgress: currentProgress ?? this.currentProgress,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Progress as a percentage (0.0 to 1.0)
  double get progressPercent {
    if (targetValue <= 0) return 1.0;
    return (currentProgress / targetValue).clamp(0.0, 1.0);
  }
}

/// Types of challenges
enum ChallengeType {
  scoreInGame, // Get X score in a specific game
  reachLevel, // Reach level X in a specific game
  playAnyGame, // Play any arcade game
}

/// Generator for daily challenges
class ChallengeGenerator {
  static const int challengeCount = 3;
  static const int xpPerChallenge = 50;

  /// Generate challenges for a specific date
  static List<Challenge> generateForDate(DateTime date) {
    // Use date as seed for consistent daily challenges
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final random = Random(seed);

    final challenges = <Challenge>[];
    final usedGames = <ArcadeGameType>{};

    // Challenge templates
    final templates = [_scoreChallenge, _levelChallenge, _scoreChallenge];

    for (int i = 0; i < challengeCount; i++) {
      final game = _getRandomGame(random, usedGames);
      usedGames.add(game);

      final template = templates[i];
      challenges.add(template(i, game, random));
    }

    return challenges;
  }

  static ArcadeGameType _getRandomGame(
    Random random,
    Set<ArcadeGameType> used,
  ) {
    final available = ArcadeGameType.values
        .where((g) => !used.contains(g))
        .toList();
    return available[random.nextInt(available.length)];
  }

  static Challenge _scoreChallenge(
    int index,
    ArcadeGameType game,
    Random random,
  ) {
    // Score targets: 300, 500, 750, 1000
    final targets = [300, 500, 750, 1000];
    final target = targets[random.nextInt(targets.length)];

    return Challenge(
      id: 'score_${game.name}_$index',
      type: ChallengeType.scoreInGame,
      gameType: game,
      targetValue: target,
      xpReward: xpPerChallenge,
    );
  }

  static Challenge _levelChallenge(
    int index,
    ArcadeGameType game,
    Random random,
  ) {
    // Level targets: 3, 5, 7
    final targets = [3, 5, 7];
    final target = targets[random.nextInt(targets.length)];

    return Challenge(
      id: 'level_${game.name}_$index',
      type: ChallengeType.reachLevel,
      gameType: game,
      targetValue: target,
      xpReward: xpPerChallenge,
    );
  }
}
