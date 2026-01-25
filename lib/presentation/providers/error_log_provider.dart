import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/error_log_model.dart';

/// State containing all error log entries
class ErrorLogState {
  final List<ErrorLogEntry> entries;

  const ErrorLogState({this.entries = const []});

  int get totalEntries => entries.length;
  int get totalWrongCount => entries.fold(0, (sum, e) => sum + e.wrongCount);

  ErrorLogState copyWith({List<ErrorLogEntry>? entries}) {
    return ErrorLogState(entries: entries ?? this.entries);
  }
}

/// Notifier for error log management
class ErrorLogNotifier extends StateNotifier<ErrorLogState> {
  ErrorLogNotifier() : super(const ErrorLogState()) {
    _loadState();
  }

  static const _storageKey = 'error_log_entries';

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_storageKey);

    if (jsonStr != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonStr);
        final entries = jsonList
            .map((e) => ErrorLogEntry.fromJson(e as Map<String, dynamic>))
            .toList();
        state = ErrorLogState(entries: entries);
      } catch (e) {
        state = const ErrorLogState();
      }
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.entries.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  /// Add a word or increment its wrong count if already exists
  Future<void> addWord(String word, String translation) async {
    final existingIndex = state.entries.indexWhere(
      (e) => e.word.toLowerCase() == word.toLowerCase(),
    );

    List<ErrorLogEntry> newEntries;

    if (existingIndex >= 0) {
      // Increment wrong count
      newEntries = List.from(state.entries);
      final existing = newEntries[existingIndex];
      newEntries[existingIndex] = existing.copyWith(
        wrongCount: existing.wrongCount + 1,
      );
    } else {
      // Add new entry
      newEntries = [
        ...state.entries,
        ErrorLogEntry(
          word: word,
          translation: translation,
          wrongCount: 1,
          addedAt: DateTime.now(),
        ),
      ];
    }

    state = state.copyWith(entries: newEntries);
    await _saveState();
  }

  /// Remove one X mark, or remove word if only 1 X remaining
  Future<void> removeMarkOrWord(String word) async {
    final existingIndex = state.entries.indexWhere(
      (e) => e.word.toLowerCase() == word.toLowerCase(),
    );

    if (existingIndex < 0) return;

    List<ErrorLogEntry> newEntries = List.from(state.entries);
    final existing = newEntries[existingIndex];

    if (existing.wrongCount <= 1) {
      // Remove entire entry
      newEntries.removeAt(existingIndex);
    } else {
      // Decrement wrong count
      newEntries[existingIndex] = existing.copyWith(
        wrongCount: existing.wrongCount - 1,
      );
    }

    state = state.copyWith(entries: newEntries);
    await _saveState();
  }

  /// Clear all entries (for reset)
  Future<void> clearAll() async {
    state = const ErrorLogState();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}

/// Provider for error log state
final errorLogProvider = StateNotifierProvider<ErrorLogNotifier, ErrorLogState>(
  (ref) => ErrorLogNotifier(),
);
