import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final ThemeMode themeMode;
  final double ttsRate;
  final double ttsVolume;
  final double ttsPitch;
  final Locale locale;
  final String userName;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.ttsRate = 0.5,
    this.ttsVolume = 1.0,
    this.ttsPitch = 1.0,
    this.locale = const Locale('tr'),
    this.userName = '',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? ttsRate,
    double? ttsVolume,
    double? ttsPitch,
    Locale? locale,
    String? userName,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      ttsRate: ttsRate ?? this.ttsRate,
      ttsVolume: ttsVolume ?? this.ttsVolume,
      ttsPitch: ttsPitch ?? this.ttsPitch,
      locale: locale ?? this.locale,
      userName: userName ?? this.userName,
    );
  }
}

/// Settings notifier for managing app settings
class SettingsNotifier extends StateNotifier<SettingsState> {
  static const String _localeKey = 'locale';
  static const String _themeModeKey = 'theme_mode';
  static const String _ttsRateKey = 'tts_rate';
  static const String _ttsVolumeKey = 'tts_volume';
  static const String _ttsPitchKey = 'tts_pitch';
  static const String _userNameKey = 'user_name';

  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_themeModeKey) ?? 0;
    final localeCode = prefs.getString(_localeKey);
    final userName = prefs.getString(_userNameKey) ?? '';

    state = SettingsState(
      themeMode: ThemeMode.values[themeModeIndex],
      ttsRate: prefs.getDouble(_ttsRateKey) ?? 0.5,
      ttsVolume: prefs.getDouble(_ttsVolumeKey) ?? 1.0,
      ttsPitch: prefs.getDouble(_ttsPitchKey) ?? 1.0,
      locale: localeCode != null ? Locale(localeCode) : const Locale('tr'),
      userName: userName,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> setTtsRate(double rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsRateKey, rate);
    state = state.copyWith(ttsRate: rate);
  }

  Future<void> setTtsVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsVolumeKey, volume);
    state = state.copyWith(ttsVolume: volume);
  }

  Future<void> setTtsPitch(double pitch) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsPitchKey, pitch);
    state = state.copyWith(ttsPitch: pitch);
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
    state = state.copyWith(userName: name);
  }
}

/// Provider for settings
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
