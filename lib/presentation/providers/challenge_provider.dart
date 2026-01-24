import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/challenge_model.dart';
import 'arcade_provider.dart';
import 'pet_provider.dart';

/// State for daily challenges
class ChallengesState {
  final List<Challenge> challenges;
  final DateTime lastResetDate;
  final bool isLoading;

  const ChallengesState({
    this.challenges = const [],
    required this.lastResetDate,
    this.isLoading = true,
  });

  ChallengesState copyWith({
    List<Challenge>? challenges,
    DateTime? lastResetDate,
    bool? isLoading,
  }) {
    return ChallengesState(
      challenges: challenges ?? this.challenges,
      lastResetDate: lastResetDate ?? this.lastResetDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int get completedCount => challenges.where((c) => c.isCompleted).length;
  int get totalXpEarned => challenges
      .where((c) => c.isCompleted)
      .fold(0, (sum, c) => sum + c.xpReward);
}

/// Notifier for managing daily challenges
class ChallengesNotifier extends StateNotifier<ChallengesState> {
  final Ref ref;
  static const _lastResetKey = 'challenges_last_reset';
  static const _completedPrefix = 'challenge_completed_';

  ChallengesNotifier(this.ref)
    : super(ChallengesState(lastResetDate: DateTime.now())) {
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month}-${today.day}';

    final lastResetStr = prefs.getString(_lastResetKey);
    final needsReset = lastResetStr != todayKey;

    if (needsReset) {
      // Clear old completed challenges
      final keys = prefs.getKeys().where((k) => k.startsWith(_completedPrefix));
      for (final key in keys) {
        await prefs.remove(key);
      }
      await prefs.setString(_lastResetKey, todayKey);
    }

    // Generate today's challenges
    final challenges = ChallengeGenerator.generateForDate(today);

    // Load completion status
    final updatedChallenges = <Challenge>[];
    for (final challenge in challenges) {
      final isCompleted =
          prefs.getBool('$_completedPrefix${challenge.id}') ?? false;

      // Get current progress from arcade state
      int progress = 0;
      if (challenge.gameType != null) {
        final arcadeState = ref.read(arcadeHighScoresProvider);
        if (challenge.type == ChallengeType.scoreInGame) {
          progress = arcadeState.getScore(challenge.gameType!);
        } else if (challenge.type == ChallengeType.reachLevel) {
          progress = arcadeState.getLevel(challenge.gameType!);
        }
      }

      updatedChallenges.add(
        challenge.copyWith(
          currentProgress: progress,
          isCompleted: isCompleted || progress >= challenge.targetValue,
        ),
      );
    }

    state = state.copyWith(
      challenges: updatedChallenges,
      lastResetDate: today,
      isLoading: false,
    );
  }

  /// Check and update challenge progress after a game
  Future<void> checkProgress(
    ArcadeGameType game, {
    int? newScore,
    int? newLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedChallenges = <Challenge>[];

    for (final challenge in state.challenges) {
      if (challenge.isCompleted) {
        updatedChallenges.add(challenge);
        continue;
      }

      if (challenge.gameType != game) {
        updatedChallenges.add(challenge);
        continue;
      }

      int progress = challenge.currentProgress;
      bool shouldComplete = false;

      if (challenge.type == ChallengeType.scoreInGame && newScore != null) {
        progress = newScore > progress ? newScore : progress;
        shouldComplete = progress >= challenge.targetValue;
      } else if (challenge.type == ChallengeType.reachLevel &&
          newLevel != null) {
        progress = newLevel > progress ? newLevel : progress;
        shouldComplete = progress >= challenge.targetValue;
      }

      if (shouldComplete && !challenge.isCompleted) {
        // Mark as completed
        await prefs.setBool('$_completedPrefix${challenge.id}', true);

        // Award XP
        ref.read(petProvider.notifier).addExperience(challenge.xpReward);

        updatedChallenges.add(
          challenge.copyWith(currentProgress: progress, isCompleted: true),
        );
      } else {
        updatedChallenges.add(challenge.copyWith(currentProgress: progress));
      }
    }

    state = state.copyWith(challenges: updatedChallenges);
  }

  /// Refresh challenges (e.g., when returning to app)
  Future<void> refresh() async {
    await _initialize();
  }
}

/// Provider for daily challenges
final challengesProvider =
    StateNotifierProvider<ChallengesNotifier, ChallengesState>(
      (ref) => ChallengesNotifier(ref),
    );
