import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../core/constants/subscription_constants.dart';
import '../../core/services/subscription_service.dart';
import '../../domain/models/subscription_state.dart';

/// Provider for SubscriptionService singleton
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});

/// StateNotifier for managing subscription state
class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _service;
  void Function(CustomerInfo)? _customerInfoListener;

  SubscriptionNotifier(this._service, Ref ref)
      : super(const SubscriptionState(isLoading: true)) {
    _init();
  }

  /// Initialize subscription state
  Future<void> _init() async {
    try {
      // First try to load cached status for immediate UI
      final cached = await _service.loadCachedStatus();
      if (cached != null) {
        state = cached.copyWith(isLoading: true);
      }

      // Then fetch fresh status from RevenueCat
      await refresh();

      // Set up listener for subscription changes
      _setupCustomerInfoListener();
    } catch (e) {
      debugPrint('Error initializing subscription: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Set up listener for real-time subscription updates
  void _setupCustomerInfoListener() {
    _customerInfoListener = (customerInfo) {
      _updateStateFromCustomerInfo(customerInfo);
    };
    _service.addCustomerInfoUpdateListener(_customerInfoListener!);
  }

  /// Update state from CustomerInfo
  void _updateStateFromCustomerInfo(CustomerInfo customerInfo) {
    final hasPremium = customerInfo.entitlements.active
        .containsKey(SubscriptionConstants.premiumEntitlement);
    final tier = _service.getTierFromCustomerInfo(customerInfo);
    final expirationDate = _service.getExpirationDate(customerInfo);

    final newState = SubscriptionState(
      isPremium: hasPremium,
      tier: tier,
      expirationDate: expirationDate,
      isLoading: false,
    );

    state = newState;

    // Cache the status for offline access
    _service.cacheSubscriptionStatus(newState);
  }

  /// Link RevenueCat to Firebase user after authentication
  Future<void> linkToUser(String userId) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final customerInfo = await _service.identifyUser(userId);
      _updateStateFromCustomerInfo(customerInfo);
    } catch (e) {
      debugPrint('Error linking user: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Refresh subscription status from RevenueCat
  Future<void> refresh() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final customerInfo = await _service.getCustomerInfo();
      _updateStateFromCustomerInfo(customerInfo);
    } catch (e) {
      debugPrint('Error refreshing subscription: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Present paywall and handle result
  Future<bool> showPaywall() async {
    try {
      final result = await _service.presentPaywall();

      if (result == PaywallResult.purchased ||
          result == PaywallResult.restored) {
        await refresh();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error showing paywall: $e');
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  /// Present paywall only if user is not premium
  Future<bool> showPaywallIfNeeded() async {
    try {
      final result = await _service.presentPaywallIfNeeded();

      if (result == null) {
        // User is already premium
        return true;
      }

      if (result == PaywallResult.purchased ||
          result == PaywallResult.restored) {
        await refresh();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error showing paywall if needed: $e');
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  /// Present customer center for subscription management
  Future<void> showCustomerCenter() async {
    try {
      await _service.presentCustomerCenter();
      // Refresh after customer center closes
      await refresh();
    } catch (e) {
      debugPrint('Error showing customer center: $e');
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Restore previous purchases
  Future<bool> restorePurchases() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final customerInfo = await _service.restorePurchases();
      _updateStateFromCustomerInfo(customerInfo);

      return state.isPremium;
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Handle user sign-out
  Future<void> handleSignOut() async {
    try {
      await _service.logOut();
      state = const SubscriptionState(
        isPremium: false,
        tier: SubscriptionTier.free,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('Error handling sign out: $e');
    }
  }

  /// Clear any error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  @override
  void dispose() {
    if (_customerInfoListener != null) {
      _service.removeCustomerInfoUpdateListener(_customerInfoListener!);
    }
    super.dispose();
  }
}

/// Provider for subscription state
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final service = ref.watch(subscriptionServiceProvider);
  return SubscriptionNotifier(service, ref);
});

/// Convenience provider: is user premium?
final isPremiumProvider = Provider<bool>((ref) {
  final state = ref.watch(subscriptionProvider);
  return state.isPremium;
});

/// Convenience provider: subscription tier
final subscriptionTierProvider = Provider<SubscriptionTier>((ref) {
  final state = ref.watch(subscriptionProvider);
  return state.tier;
});

/// Convenience provider: is subscription loading?
final isSubscriptionLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(subscriptionProvider);
  return state.isLoading;
});
