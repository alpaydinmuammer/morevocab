import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/badge_model.dart';
import 'arcade_provider.dart';
import 'streak_provider.dart';

/// State containing all badges with their unlock status
class BadgeState {
  final Map<BadgeType, DateTime?> unlockedBadges;
  final BadgeType? lastUnlockedBadge;

  const BadgeState({this.unlockedBadges = const {}, this.lastUnlockedBadge});

  bool isUnlocked(BadgeType type) => unlockedBadges[type] != null;

  int get unlockedCount => unlockedBadges.values.where((d) => d != null).length;

  BadgeState copyWith({
    Map<BadgeType, DateTime?>? unlockedBadges,
    BadgeType? lastUnlockedBadge,
  }) {
    return BadgeState(
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
      lastUnlockedBadge: lastUnlockedBadge,
    );
  }
}

/// Notifier for badge achievements
class BadgeNotifier extends StateNotifier<BadgeState> {
  BadgeNotifier() : super(const BadgeState()) {
    _loadState();
  }

  static const _storageKey = 'user_badges';

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_storageKey);

    if (jsonStr != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonStr);
        final unlocked = <BadgeType, DateTime?>{};

        for (final type in BadgeType.values) {
          final dateStr = json[type.name] as String?;
          if (dateStr != null) {
            unlocked[type] = DateTime.parse(dateStr);
          }
        }

        state = BadgeState(unlockedBadges: unlocked);
      } catch (e) {
        state = const BadgeState();
      }
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    final json = <String, String>{};

    for (final entry in state.unlockedBadges.entries) {
      if (entry.value != null) {
        json[entry.key.name] = entry.value!.toIso8601String();
      }
    }

    await prefs.setString(_storageKey, jsonEncode(json));
  }

  /// Check and unlock badges based on current arcade and streak state
  Future<List<BadgeType>> checkAndUnlockBadges({
    required ArcadeState arcadeState,
    required StreakState streakState,
  }) async {
    final newlyUnlocked = <BadgeType>[];
    final now = DateTime.now();

    // Helper to unlock a badge
    void tryUnlock(BadgeType type, bool condition) {
      if (!state.isUnlocked(type) && condition) {
        newlyUnlocked.add(type);
      }
    }

    // Anagram badges (Level-based)
    final anagramLevel = arcadeState.getLevel(ArcadeGameType.anagram);
    tryUnlock(BadgeType.anagramRookie, anagramLevel >= 5);
    tryUnlock(BadgeType.anagramExpert, anagramLevel >= 15);
    tryUnlock(BadgeType.anagramChampion, anagramLevel >= 30);

    // Word Chain badges (Score-based) - harder
    final chainScore = arcadeState.getScore(ArcadeGameType.wordChain);
    tryUnlock(BadgeType.chainStarter, chainScore >= 500);
    tryUnlock(BadgeType.chainMaster, chainScore >= 1000);
    tryUnlock(BadgeType.chainLegend, chainScore >= 1500);

    // Odd One Out badges (Score-based) - harder
    final oddScore = arcadeState.getScore(ArcadeGameType.oddOneOut);
    tryUnlock(BadgeType.observer, oddScore >= 100);
    tryUnlock(BadgeType.detective, oddScore >= 250);
    tryUnlock(BadgeType.sharpshooter, oddScore >= 500);

    // Emoji Puzzle badges (Level-based)
    final emojiLevel = arcadeState.getLevel(ArcadeGameType.emojiPuzzle);
    tryUnlock(BadgeType.emojiSolver, emojiLevel >= 10);
    tryUnlock(BadgeType.puzzleMaster, emojiLevel >= 20);
    tryUnlock(BadgeType.emojiLegend, emojiLevel >= 30);

    // Word Builder badges (Score-based) - harder
    final wordBuilderScore = arcadeState.getScore(ArcadeGameType.wordBuilder);
    tryUnlock(BadgeType.wordWorker, wordBuilderScore >= 100);
    tryUnlock(BadgeType.wordArchitect, wordBuilderScore >= 250);
    tryUnlock(BadgeType.wordKing, wordBuilderScore >= 500);

    // Streak badges - harder
    final streak = streakState.bestStreak;
    tryUnlock(BadgeType.fireSpirit, streak >= 7);
    tryUnlock(BadgeType.dedicated, streak >= 30);
    tryUnlock(BadgeType.legendary, streak >= 100);

    // Special badges - based on total badges unlocked
    final totalUnlocked = state.unlockedCount + newlyUnlocked.length;
    tryUnlock(BadgeType.firstStep, totalUnlocked >= 5);
    tryUnlock(BadgeType.arcadeFan, totalUnlocked >= 10);
    tryUnlock(BadgeType.brainBoss, totalUnlocked >= 20);

    // Update state with newly unlocked badges
    if (newlyUnlocked.isNotEmpty) {
      final updated = Map<BadgeType, DateTime?>.from(state.unlockedBadges);
      for (final type in newlyUnlocked) {
        updated[type] = now;
      }
      state = state.copyWith(
        unlockedBadges: updated,
        lastUnlockedBadge: newlyUnlocked.first,
      );
      await _saveState();
    }

    return newlyUnlocked;
  }

  /// Clear notification for last unlocked badge
  void clearLastUnlocked() {
    state = state.copyWith(lastUnlockedBadge: null);
  }
}

/// Provider for badge state
final badgeProvider = StateNotifierProvider<BadgeNotifier, BadgeState>(
  (ref) => BadgeNotifier(),
);
