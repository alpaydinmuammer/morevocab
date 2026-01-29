import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';
import '../constants/subscription_constants.dart';
import '../../domain/models/subscription_state.dart';

/// Service for managing RevenueCat subscriptions
/// Singleton pattern matching CloudSyncService and LeaderboardService
class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  bool _isInitialized = false;

  /// Check if SDK is initialized
  bool get isInitialized => _isInitialized;

  /// Initialize RevenueCat SDK
  /// Call this in main() before runApp()
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await Purchases.setLogLevel(LogLevel.debug);

      final configuration = PurchasesConfiguration(
        SubscriptionConstants.apiKey,
      );
      await Purchases.configure(configuration);

      _isInitialized = true;
      debugPrint('RevenueCat SDK initialized successfully');
    } catch (e) {
      debugPrint('Error initializing RevenueCat: $e');
      rethrow;
    }
  }

  /// Configure user identity (call after Firebase Auth sign-in)
  /// Links RevenueCat purchases to Firebase user ID
  Future<CustomerInfo> identifyUser(String userId) async {
    _ensureInitialized();
    try {
      final customerInfo = await Purchases.logIn(userId);
      debugPrint('RevenueCat: User identified - $userId');
      return customerInfo.customerInfo;
    } catch (e) {
      debugPrint('Error identifying user: $e');
      rethrow;
    }
  }

  /// Log out user from RevenueCat (call on sign-out)
  Future<CustomerInfo> logOut() async {
    _ensureInitialized();
    try {
      final customerInfo = await Purchases.logOut();
      debugPrint('RevenueCat: User logged out');
      return customerInfo;
    } catch (e) {
      debugPrint('Error logging out: $e');
      rethrow;
    }
  }

  /// Get current customer info (subscription status)
  Future<CustomerInfo> getCustomerInfo() async {
    _ensureInitialized();
    return await Purchases.getCustomerInfo();
  }

  /// Check if user has premium entitlement
  Future<bool> checkPremiumStatus() async {
    _ensureInitialized();
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final hasPremium = customerInfo.entitlements.active.containsKey(
        SubscriptionConstants.premiumEntitlement,
      );
      debugPrint('RevenueCat: Premium status = $hasPremium');
      return hasPremium;
    } catch (e) {
      debugPrint('Error checking premium status: $e');
      // Fallback to cached status
      return await _loadCachedPremiumStatus();
    }
  }

  /// Get subscription tier from customer info
  SubscriptionTier getTierFromCustomerInfo(CustomerInfo customerInfo) {
    final entitlement = customerInfo
        .entitlements
        .active[SubscriptionConstants.premiumEntitlement];
    if (entitlement == null) return SubscriptionTier.free;

    final productId = entitlement.productIdentifier;

    if (productId.contains('lifetime')) {
      return SubscriptionTier.lifetime;
    } else if (productId.contains('yearly')) {
      return SubscriptionTier.yearly;
    } else if (productId.contains('monthly')) {
      return SubscriptionTier.monthly;
    }

    return SubscriptionTier.free;
  }

  /// Get expiration date from customer info
  DateTime? getExpirationDate(CustomerInfo customerInfo) {
    final entitlement = customerInfo
        .entitlements
        .active[SubscriptionConstants.premiumEntitlement];
    if (entitlement == null) return null;

    final expirationStr = entitlement.expirationDate;
    if (expirationStr == null) return null; // Lifetime has no expiration

    return DateTime.tryParse(expirationStr);
  }

  /// Present RevenueCat Paywall
  /// Returns PaywallResult indicating what happened
  Future<PaywallResult> presentPaywall() async {
    _ensureInitialized();
    try {
      final result = await RevenueCatUI.presentPaywall();
      debugPrint('RevenueCat Paywall result: $result');
      return result;
    } catch (e) {
      debugPrint('Error presenting paywall: $e');
      rethrow;
    }
  }

  /// Present RevenueCat Paywall if user is not premium
  /// Returns PaywallResult or null if user is already premium
  Future<PaywallResult?> presentPaywallIfNeeded() async {
    _ensureInitialized();
    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        SubscriptionConstants.premiumEntitlement,
      );
      debugPrint('RevenueCat PaywallIfNeeded result: $result');
      return result;
    } catch (e) {
      debugPrint('Error presenting paywall if needed: $e');
      rethrow;
    }
  }

  /// Present RevenueCat Customer Center
  /// For managing subscriptions, restoring purchases, etc.
  Future<void> presentCustomerCenter() async {
    _ensureInitialized();
    try {
      await RevenueCatUI.presentCustomerCenter();
      debugPrint('RevenueCat: Customer Center presented');
    } catch (e) {
      debugPrint('Error presenting customer center: $e');
      rethrow;
    }
  }

  /// Restore purchases
  Future<CustomerInfo> restorePurchases() async {
    _ensureInitialized();
    try {
      final customerInfo = await Purchases.restorePurchases();
      debugPrint('RevenueCat: Purchases restored');
      return customerInfo;
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
      rethrow;
    }
  }

  /// Get available offerings (products)
  Future<Offerings?> getOfferings() async {
    _ensureInitialized();
    try {
      final offerings = await Purchases.getOfferings();
      debugPrint(
        'RevenueCat: Offerings loaded - ${offerings.current?.identifier}',
      );
      return offerings;
    } catch (e) {
      debugPrint('Error getting offerings: $e');
      return null;
    }
  }

  /// Purchase a specific package
  Future<CustomerInfo> purchasePackage(Package package) async {
    _ensureInitialized();
    try {
      // purchasePackage is deprecated but purchase(PurchaseParams) has constructor issues
      // and mismatch return types. We use purchasePackage and ignore the return value
      // (which appears to be PurchaseResult in v9) and fetch fresh info instead.
      // ignore: deprecated_member_use
      await Purchases.purchasePackage(package);

      debugPrint('RevenueCat: Purchase successful');
      return await Purchases.getCustomerInfo();
    } catch (e) {
      debugPrint('Error purchasing package: $e');
      rethrow;
    }
  }

  /// Cache subscription status for offline access
  Future<void> cacheSubscriptionStatus(SubscriptionState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        StorageKeys.subscriptionStatus,
        jsonEncode(state.toJson()),
      );
      debugPrint('Subscription status cached');
    } catch (e) {
      debugPrint('Error caching subscription status: $e');
    }
  }

  /// Load cached subscription status
  Future<SubscriptionState?> loadCachedStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(StorageKeys.subscriptionStatus);
      if (jsonStr == null) return null;

      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return SubscriptionState.fromJson(json);
    } catch (e) {
      debugPrint('Error loading cached subscription status: $e');
      return null;
    }
  }

  /// Load cached premium status (simple bool)
  Future<bool> _loadCachedPremiumStatus() async {
    try {
      final cached = await loadCachedStatus();
      return cached?.isPremium ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Listen to customer info changes
  void addCustomerInfoUpdateListener(void Function(CustomerInfo) listener) {
    _ensureInitialized();
    Purchases.addCustomerInfoUpdateListener(listener);
  }

  /// Remove customer info update listener
  void removeCustomerInfoUpdateListener(void Function(CustomerInfo) listener) {
    Purchases.removeCustomerInfoUpdateListener(listener);
  }

  /// Ensure SDK is initialized before operations
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'SubscriptionService not initialized. Call initialize() first.',
      );
    }
  }
}
