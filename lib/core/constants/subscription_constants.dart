import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// RevenueCat subscription constants
class SubscriptionConstants {
  SubscriptionConstants._();

  // ===========================================
  // REVENUECAT API KEYS
  // ===========================================

  /// RevenueCat API key (platform-specific)
  static String get apiKey {
    if (Platform.isAndroid) {
      return dotenv.env['REVENUECAT_API_KEY_ANDROID'] ??
          'test_vQZKKOuKawpaqBfkDEGTFmpQXkr';
    } else if (Platform.isIOS) {
      return dotenv.env['REVENUECAT_API_KEY_IOS'] ??
          'test_vQZKKOuKawpaqBfkDEGTFmpQXkr';
    }
    return dotenv.env['REVENUECAT_API_KEY_ANDROID'] ??
        'test_vQZKKOuKawpaqBfkDEGTFmpQXkr';
  }

  // ===========================================
  // ENTITLEMENTS
  // ===========================================

  /// Premium entitlement identifier
  static const String premiumEntitlement = 'More Vocab Pro';

  // ===========================================
  // PRODUCT IDENTIFIERS
  // ===========================================

  /// Monthly subscription product ID
  static const String monthlyProductId = 'monthly';

  /// Yearly subscription product ID
  static const String yearlyProductId = 'yearly';

  /// Lifetime purchase product ID
  static const String lifetimeProductId = 'lifetime';

  // ===========================================
  // FREE TIER LIMITATIONS
  // ===========================================

  /// Number of cloud syncs allowed per day for free users
  static const int freeSyncLimitPerDay = 1;

  /// Cooldown duration between syncs for free users
  static const Duration freeSyncCooldown = Duration(hours: 24);
}
