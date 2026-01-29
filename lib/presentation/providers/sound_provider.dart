import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/sound_service.dart';

/// Provider for SoundService singleton
final soundServiceProvider = Provider<SoundService>((ref) {
  return SoundService();
});

/// Provider for sound enabled state
final soundEnabledProvider = StateProvider<bool>((ref) {
  return SoundService().soundEnabled;
});

/// Provider for sound volume
final soundVolumeProvider = StateProvider<double>((ref) {
  return SoundService().volume;
});

/// Extension methods for easy sound playback
extension SoundProviderExtension on WidgetRef {
  /// Play a sound effect
  void playSound(SoundEffect effect) {
    read(soundServiceProvider).play(effect);
  }

  /// Toggle sound on/off
  Future<void> toggleSound() async {
    final service = read(soundServiceProvider);
    await service.toggleSound();
    read(soundEnabledProvider.notifier).state = service.soundEnabled;
  }

  /// Set sound enabled state
  Future<void> setSoundEnabled(bool enabled) async {
    final service = read(soundServiceProvider);
    await service.setSoundEnabled(enabled);
    read(soundEnabledProvider.notifier).state = enabled;
  }

  /// Set volume
  Future<void> setSoundVolume(double volume) async {
    final service = read(soundServiceProvider);
    await service.setVolume(volume);
    read(soundVolumeProvider.notifier).state = volume;
  }
}
