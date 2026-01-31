import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/subscription_service.dart';
import '../../domain/models/subscription_state.dart';

/// Provider for SubscriptionService singleton
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});

/// Stub StateNotifier - RevenueCat disabled for initial release
class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  SubscriptionNotifier(SubscriptionService service, Ref ref)
      : super(const SubscriptionState(
          isPremium: false,
          tier: SubscriptionTier.free,
          isLoading: false,
        ));

  /// No-op for stub
  Future<void> linkToUser(String userId) async {}

  /// No-op for stub
  Future<void> refresh() async {}

  /// Returns false - paywall disabled
  Future<bool> showPaywall() async => false;

  /// Returns false - paywall disabled
  Future<bool> showPaywallIfNeeded() async => false;

  /// No-op for stub
  Future<void> showCustomerCenter() async {}

  /// Returns false - restore disabled
  Future<bool> restorePurchases() async => false;

  /// No-op for stub
  Future<void> handleSignOut() async {}

  /// No-op for stub
  void clearError() {}
}

/// Provider for subscription state
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final service = ref.watch(subscriptionServiceProvider);
  return SubscriptionNotifier(service, ref);
});

/// Convenience provider: is user premium? (always false for now)
final isPremiumProvider = Provider<bool>((ref) {
  return false;
});

/// Convenience provider: subscription tier (always free for now)
final subscriptionTierProvider = Provider<SubscriptionTier>((ref) {
  return SubscriptionTier.free;
});

/// Convenience provider: is subscription loading? (always false for now)
final isSubscriptionLoadingProvider = Provider<bool>((ref) {
  return false;
});
