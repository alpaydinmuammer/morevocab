import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';

class SettingsState {
  final ThemeMode themeMode;
  final double ttsRate;
  final double ttsVolume;
  final double ttsPitch;
  final Locale locale;
  final String userName;
  final bool hasSeenOnboarding;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.ttsRate = 0.5,
    this.ttsVolume = 1.0,
    this.ttsPitch = 1.0,
    this.locale = const Locale('tr'),
    this.userName = '',
    this.hasSeenOnboarding = false,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? ttsRate,
    double? ttsVolume,
    double? ttsPitch,
    Locale? locale,
    String? userName,
    bool? hasSeenOnboarding,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      ttsRate: ttsRate ?? this.ttsRate,
      ttsVolume: ttsVolume ?? this.ttsVolume,
      ttsPitch: ttsPitch ?? this.ttsPitch,
      locale: locale ?? this.locale,
      userName: userName ?? this.userName,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}

/// Settings notifier for managing app settings
class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(StorageKeys.themeMode) ?? 0;
    final localeCode = prefs.getString(StorageKeys.locale);
    final userName = prefs.getString(StorageKeys.userName) ?? '';
    final hasSeenOnboarding = prefs.getBool(StorageKeys.hasSeenOnboarding) ?? false;

    state = SettingsState(
      themeMode: ThemeMode.values[themeModeIndex],
      ttsRate: prefs.getDouble(StorageKeys.ttsRate) ?? 0.5,
      ttsVolume: prefs.getDouble(StorageKeys.ttsVolume) ?? 1.0,
      ttsPitch: prefs.getDouble(StorageKeys.ttsPitch) ?? 1.0,
      locale: localeCode != null ? Locale(localeCode) : const Locale('tr'),
      userName: userName,
      hasSeenOnboarding: hasSeenOnboarding,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageKeys.themeMode, mode.index);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.locale, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> setTtsRate(double rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(StorageKeys.ttsRate, rate);
    state = state.copyWith(ttsRate: rate);
  }

  Future<void> setTtsVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(StorageKeys.ttsVolume, volume);
    state = state.copyWith(ttsVolume: volume);
  }

  Future<void> setTtsPitch(double pitch) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(StorageKeys.ttsPitch, pitch);
    state = state.copyWith(ttsPitch: pitch);
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.userName, name);
    state = state.copyWith(userName: name);
  }

  Future<void> setHasSeenOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.hasSeenOnboarding, value);
    state = state.copyWith(hasSeenOnboarding: value);
  }
}

/// Provider for settings
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
