/// Subscription tier enumeration
enum SubscriptionTier {
  free,
  monthly,
  yearly,
  lifetime,
}

/// Represents the user's subscription status
class SubscriptionState {
  final bool isPremium;
  final SubscriptionTier tier;
  final DateTime? expirationDate;
  final bool isLoading;
  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.tier = SubscriptionTier.free,
    this.expirationDate,
    this.isLoading = true,
    this.errorMessage,
  });

  /// Check if subscription is active and not expired
  bool get isActive {
    if (!isPremium) return false;
    if (tier == SubscriptionTier.lifetime) return true;
    if (expirationDate == null) return false;
    return DateTime.now().isBefore(expirationDate!);
  }

  /// Check if user has lifetime access
  bool get isLifetime => tier == SubscriptionTier.lifetime && isPremium;

  /// Get human-readable tier name
  String get tierName {
    switch (tier) {
      case SubscriptionTier.free:
        return 'Free';
      case SubscriptionTier.monthly:
        return 'Monthly';
      case SubscriptionTier.yearly:
        return 'Yearly';
      case SubscriptionTier.lifetime:
        return 'Lifetime';
    }
  }

  SubscriptionState copyWith({
    bool? isPremium,
    SubscriptionTier? tier,
    DateTime? expirationDate,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      tier: tier ?? this.tier,
      expirationDate: expirationDate ?? this.expirationDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  /// Serialize to JSON for offline caching
  Map<String, dynamic> toJson() {
    return {
      'isPremium': isPremium,
      'tier': tier.name,
      'expirationDate': expirationDate?.toIso8601String(),
    };
  }

  /// Deserialize from JSON
  factory SubscriptionState.fromJson(Map<String, dynamic> json) {
    return SubscriptionState(
      isPremium: json['isPremium'] as bool? ?? false,
      tier: SubscriptionTier.values.byName(json['tier'] as String? ?? 'free'),
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'] as String)
          : null,
      isLoading: false,
    );
  }
}
