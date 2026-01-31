import 'package:flutter/foundation.dart';

/// Stub AdService - AdMob disabled for initial release
/// TODO: Re-enable AdMob after app is published
class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  /// Initialize - no-op for stub
  Future<void> init() async {}

  /// Load interstitial - no-op for stub
  void loadInterstitial() {}

  /// Show interstitial - just call the callback
  void showInterstitial({
    VoidCallback? onAdDismissed,
    bool checkFrequency = true,
  }) {
    onAdDismissed?.call();
  }
}
