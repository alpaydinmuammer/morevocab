import 'package:flutter/material.dart';
import '../../../widgets/premium_background.dart';
import '../../../../l10n/app_localizations.dart';
import 'leaderboard_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArcadeLeaderboardScreen extends ConsumerWidget {
  const ArcadeLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: colorScheme.onSurface,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            l10n.wordChainTitle,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.leaderboardTitle,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48), // Balance back button
                  ],
                ),
              ),

              // Content with Stack for floating banner
              Expanded(
                child: Stack(
                  children: [
                    // Leaderboard List (always visible)
                    const Positioned.fill(
                      child: LeaderboardList(
                        gameId: 'wordChain',
                        accentColor: Colors.orange,
                      ),
                    ),

                    // Premium Warning Banner removed for initial release
                  ],
                ),
              ),

              // Banner Ad removed for initial release
            ],
          ),
        ),
      ),
    );
  }
}
