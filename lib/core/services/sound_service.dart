import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';

/// Sound effect types available in the app
enum SoundEffect {
  // Feedback sounds
  correct,
  wrong,
  cardFlip,

  // Achievement sounds
  levelUp,
  badge,
  streak,

  // UI sounds
  menuOpen,
  menuClose,
  buttonTap,
}

/// Service for managing sound effects throughout the app
class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _initialized = false;
  bool _soundEnabled = true;
  double _volume = 0.5; // 50% volume for soft sounds

  bool get soundEnabled => _soundEnabled;
  double get volume => _volume;

  /// Initialize the sound service
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Load sound preference
      final prefs = await SharedPreferences.getInstance();
      _soundEnabled = prefs.getBool(StorageKeys.soundEnabled) ?? true;
      _volume = prefs.getDouble(StorageKeys.soundVolume) ?? 0.5;

      // Configure audio player
      await _player.setVolume(_volume);
      await _player.setReleaseMode(ReleaseMode.stop);

      _initialized = true;
    } catch (_) {
      // Silently fail initialization
    }
  }

  /// Play a sound effect
  Future<void> play(SoundEffect effect) async {
    if (!_soundEnabled) return;

    try {
      final assetPath = _getAssetPath(effect);
      await _player.stop(); // Stop any currently playing sound
      await _player.setVolume(_volume);
      await _player.play(AssetSource(assetPath));
    } catch (_) {
      // Silently fail - sound is non-critical
    }
  }

  /// Get asset path for sound effect
  String _getAssetPath(SoundEffect effect) {
    switch (effect) {
      case SoundEffect.correct:
        return 'sounds/correct.mp3';
      case SoundEffect.wrong:
        return 'sounds/wrong.mp3';
      case SoundEffect.cardFlip:
        return 'sounds/card_flip.mp3';
      case SoundEffect.levelUp:
        return 'sounds/level_up.mp3';
      case SoundEffect.badge:
        return 'sounds/badge.mp3';
      case SoundEffect.streak:
        return 'sounds/streak.mp3';
      case SoundEffect.menuOpen:
        return 'sounds/menu_open.mp3';
      case SoundEffect.menuClose:
        return 'sounds/menu_close.mp3';
      case SoundEffect.buttonTap:
        return 'sounds/button_tap.mp3';
    }
  }

  /// Toggle sound on/off
  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.soundEnabled, _soundEnabled);
  }

  /// Set sound enabled state
  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.soundEnabled, _soundEnabled);
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _player.setVolume(_volume);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(StorageKeys.soundVolume, _volume);
  }

  /// Dispose resources
  void dispose() {
    _player.dispose();
  }
}
