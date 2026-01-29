import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../providers/subscription_provider.dart';
import '../widgets/premium_background.dart';

class PaywallPage extends ConsumerStatefulWidget {
  const PaywallPage({super.key});

  @override
  ConsumerState<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends ConsumerState<PaywallPage> {
  bool _isLoading = true;
  Offerings? _offerings;
  Package? _selectedPackage;

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
  }

  Future<void> _fetchOfferings() async {
    try {
      final offerings = await ref
          .read(subscriptionServiceProvider)
          .getOfferings();
      if (mounted) {
        setState(() {
          _offerings = offerings;
          // Pre-select annual package if available, otherwise first available
          if (offerings?.current != null &&
              offerings!.current!.availablePackages.isNotEmpty) {
            _selectedPackage = offerings.current!.availablePackages.firstWhere(
              (p) => p.packageType == PackageType.annual,
              orElse: () => offerings.current!.availablePackages.first,
            );
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _purchaseSelectedPackage() async {
    if (_selectedPackage == null) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(subscriptionServiceProvider)
          .purchasePackage(_selectedPackage!);

      // Success
      await ref.read(subscriptionProvider.notifier).refresh();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // User cancelled or error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.paywallPurchaseFailed(e.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _restorePurchases() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      final success = await ref
          .read(subscriptionProvider.notifier)
          .restorePurchases();
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.paywallRestoreSuccess)));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.paywallRestoreNoPurchases)),
          );
        }
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paywallRestoreFailed(e.toString()))),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: PremiumBackground(
        child: Stack(
          children: [
            // Background Gradient or Image could go here
            Column(
              children: [
                // Header Image/Logo Area
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    // Gradient removed to show PremiumBackground
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ), // Increased spacing to push text down since logo is gone
                        // Logo removed as per request
                        const SizedBox(height: 24),
                        Text(
                          l10n.paywallTitle,
                          style: TextStyle(
                            fontSize: 24, // Reduced from 28
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            l10n.paywallSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14, // Reduced from 16
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content Area
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor.withValues(
                        alpha: 0.85,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Offerings List
                        if (_isLoading && _offerings == null)
                          const Center(child: CircularProgressIndicator())
                        else if (_offerings?.current != null &&
                            _offerings!
                                .current!
                                .availablePackages
                                .isNotEmpty) ...[
                          _buildPackageList(
                            _offerings!.current!.availablePackages,
                            l10n,
                            theme,
                          ),
                          const SizedBox(height: 24),
                        ] else ...[
                          Center(child: Text(l10n.paywallNoSubscriptions)),
                          const SizedBox(height: 24),
                        ],

                        // Features List
                        Text(
                          l10n.paywallWhatsIncluded,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _FeatureItem(
                                icon: Icons.block,
                                title: l10n.featureNoAdsTitle,
                                subtitle: l10n.featureNoAdsSubtitle,
                              ),
                              _FeatureItem(
                                icon: Icons.cloud_sync_rounded,
                                title: l10n.featureSyncTitle,
                                subtitle: l10n.featureSyncSubtitle,
                              ),
                              _FeatureItem(
                                icon: Icons.leaderboard_rounded,
                                title: l10n.featureLeaderboardTitle,
                                subtitle: l10n.featureLeaderboardSubtitle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Bar
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : _purchaseSelectedPackage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF4F46E5,
                              ), // Indigo
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              shadowColor: const Color(
                                0xFF4F46E5,
                              ).withValues(alpha: 0.4),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    l10n.paywallContinue,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: _isLoading ? null : _restorePurchases,
                          child: Text(
                            l10n.paywallRestore,
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Close Button
            Positioned(
              top: 16,
              left: 16,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageList(
    List<Package> packages,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    // Sort: Annual first
    final sortedPackages = List<Package>.from(packages);
    sortedPackages.sort((a, b) {
      if (a.packageType == PackageType.annual) return -1;
      if (b.packageType == PackageType.annual) return 1;
      return 0;
    });

    return Column(
      children: sortedPackages.map((package) {
        final isSelected = _selectedPackage == package;
        // User requested $99 package to be displayed as "Yearly".
        // Usually $99 is Lifetime. So if it's lifetime, we treat it as the "Long Term" option (Yearly/Lifetime).
        // If packageType is annual, it's definitely Annual.
        // If packageType is lifetime, we will label it as "Annual" solely per user request "99 dolar olanı aylık değil yıllık olarak yaz"
        // although technically it is lifetime. Or maybe user means the Annual plan WAS showing as Monthly?
        // Let's rely on packageType but format the text better.

        final isAnnual = package.packageType == PackageType.annual;
        final isLifetime = package.packageType == PackageType.lifetime;

        String title = l10n.paywallMonthly;
        if (isAnnual) title = l10n.paywallAnnual;
        if (isLifetime) title = l10n.paywallLifetime;

        // Special override based on price if metadata is missing (heuristic)
        if (package.storeProduct.price > 50) {
          // Assume high price is Annual/Lifetime context
          if (!isAnnual && !isLifetime) title = l10n.paywallAnnual;
        }

        return GestureDetector(
          onTap: () => setState(() => _selectedPackage = package),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8), // Reduced from 12
            padding: const EdgeInsets.all(12), // Reduced from 16
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.05)
                  : theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                // Radio Circle
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 16),

                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          if (isAnnual || isLifetime) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                l10n.paywallBestValue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (isAnnual || isLifetime)
                            ? "${package.storeProduct.priceString}/${l10n.paywallAnnual.toLowerCase()}" // Simple suffix, localization ideally handles "per year"
                            : "${package.storeProduct.priceString}/${l10n.paywallMonthly.toLowerCase()}",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // Reduced from 20
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14, // Reduced from 16
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12, // Reduced from 14
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
