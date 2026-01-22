import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// State of the user's activity streak
class StreakState {
  final int currentStreak;
  final int bestStreak;
  final DateTime? lastActivityDate;
  final bool isStreakActiveToday;

  const StreakState({
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.lastActivityDate,
    this.isStreakActiveToday = false,
  });

  StreakState copyWith({
    int? currentStreak,
    int? bestStreak,
    DateTime? lastActivityDate,
    bool? isStreakActiveToday,
  }) {
    return StreakState(
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      isStreakActiveToday: isStreakActiveToday ?? this.isStreakActiveToday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'lastActivityDate': lastActivityDate?.toIso8601String(),
    };
  }

  factory StreakState.fromJson(Map<String, dynamic> json) {
    final lastDateStr = json['lastActivityDate'] as String?;
    final lastDate = lastDateStr != null ? DateTime.parse(lastDateStr) : null;

    bool activeToday = false;
    if (lastDate != null) {
      final now = DateTime.now();
      activeToday =
          now.year == lastDate.year &&
          now.month == lastDate.month &&
          now.day == lastDate.day;
    }

    return StreakState(
      currentStreak: json['currentStreak'] ?? 0,
      bestStreak: json['bestStreak'] ?? 0,
      lastActivityDate: lastDate,
      isStreakActiveToday: activeToday,
    );
  }
}

/// Notifier for user activity streak
class StreakNotifier extends StateNotifier<StreakState> {
  StreakNotifier() : super(const StreakState()) {
    _init();
  }

  static const _storageKey = 'user_streak_data';

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_storageKey);

    if (jsonStr != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonStr);
        final loadedState = StreakState.fromJson(json);

        // Validate if streak is still alive
        state = _checkAndResetStreak(loadedState);
      } catch (e) {
        state = const StreakState();
      }
    }
  }

  StreakState _checkAndResetStreak(StreakState current) {
    if (current.lastActivityDate == null) return current;

    final now = DateTime.now();
    final last = current.lastActivityDate!;

    // Normalize to midnight for day comparison
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(last.year, last.month, last.day);

    final difference = today.difference(lastDate).inDays;

    if (difference > 1) {
      // Streak broken (more than 1 day since last activity)
      return current.copyWith(currentStreak: 0, isStreakActiveToday: false);
    } else if (difference == 1) {
      // Last activity was yesterday, streak waiting for today's activity
      return current.copyWith(isStreakActiveToday: false);
    } else {
      // Last activity was today
      return current.copyWith(isStreakActiveToday: true);
    }
  }

  Future<void> recordActivity() async {
    final now = DateTime.now();

    // Check if already recorded today
    if (state.isStreakActiveToday) return;

    int newStreak = 1;
    if (state.lastActivityDate != null) {
      final last = state.lastActivityDate!;
      final today = DateTime(now.year, now.month, now.day);
      final lastDate = DateTime(last.year, last.month, last.day);

      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        // Continuous streak
        newStreak = state.currentStreak + 1;
      } else if (difference == 0) {
        // Already recorded today (should be handled by isStreakActiveToday check above)
        return;
      }
    }

    final newState = state.copyWith(
      currentStreak: newStreak,
      bestStreak: newStreak > state.bestStreak ? newStreak : state.bestStreak,
      lastActivityDate: now,
      isStreakActiveToday: true,
    );

    state = newState;
    await _saveToStorage(newState);
  }

  Future<void> _saveToStorage(StreakState data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(data.toJson()));
  }

  /// Reset streak for testing purposes
  Future<void> resetStreak() async {
    state = const StreakState();
    await _saveToStorage(state);
  }
}

/// Provider for user streak information
final streakProvider = StateNotifierProvider<StreakNotifier, StreakState>((
  ref,
) {
  return StreakNotifier();
});
