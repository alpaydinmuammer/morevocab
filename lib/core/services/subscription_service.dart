import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';
import '../../domain/models/subscription_state.dart';

/// Stub subscription service - RevenueCat disabled for initial release
/// TODO: Re-enable RevenueCat after app is published
class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  /// Initialize - no-op for stub
  Future<void> initialize() async {
    _isInitialized = true;
  }

  /// Always returns free tier for now
  Future<bool> checkPremiumStatus() async {
    return false;
  }

  /// Cache subscription status for offline access
  Future<void> cacheSubscriptionStatus(SubscriptionState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        StorageKeys.subscriptionStatus,
        '{"isPremium":false,"tier":"free"}',
      );
    } catch (_) {}
  }

  /// Load cached subscription status - always free
  Future<SubscriptionState?> loadCachedStatus() async {
    return const SubscriptionState(
      isPremium: false,
      tier: SubscriptionTier.free,
    );
  }
}
