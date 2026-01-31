import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/leaderboard_service.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../widgets/premium_background.dart';

// Standalone screen for when accessed directly (e.g. from game over)
class LeaderboardScreen extends ConsumerWidget {
  final String gameId;
  final Color accentColor;

  const LeaderboardScreen({
    super.key,
    required this.gameId,
    this.accentColor = Colors.orange,
  });

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
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
                            l10n.leaderboardTitle,
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
                            l10n.topPlayers,
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

              // Content
              Expanded(
                child: LeaderboardList(
                  gameId: gameId,
                  accentColor: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardList extends StatelessWidget {
  final String gameId;
  final Color accentColor;

  const LeaderboardList({
    super.key,
    required this.gameId,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<LeaderboardEntry>>(
      future: LeaderboardService().getTopScores(gameId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.couldNotLoadLeaderboard,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          );
        }

        final scores = snapshot.data ?? [];

        if (scores.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.noScoresYet,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 40,
            top: 10,
          ),
          itemCount: scores.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = scores[index];
            final rank = index + 1;

            return _LeaderboardCard(
              rank: rank,
              entry: entry,
              accentColor: accentColor,
            );
          },
        );
      },
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  final int rank;
  final LeaderboardEntry entry;
  final Color accentColor;

  const _LeaderboardCard({
    required this.rank,
    required this.entry,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTop3 = rank <= 3;

    Color rankColor;
    Color textColor;
    Color? glowColor;
    Gradient? borderGradient;
    Gradient? bgGradient;
    double scale = 1.0;

    if (rank == 1) {
      // Gold styling
      rankColor = const Color(0xFFFFD700);
      textColor = const Color(0xFF3E2723); // Dark brown/Bronze for text
      glowColor = Colors.amber;
      borderGradient = const LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFDB931)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      bgGradient = const LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFDB931)], // Solid gradient
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      scale = 1.05;
    } else if (rank == 2) {
      // Silver styling
      rankColor = const Color(0xFFC0C0C0);
      textColor = const Color(0xFF263238); // Dark Blue Grey for text
      glowColor = Colors.grey;
      borderGradient = const LinearGradient(
        colors: [Color(0xFFE0E0E0), Color(0xFFB0B0B0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      bgGradient = const LinearGradient(
        colors: [Color(0xFFF5F5F5), Color(0xFFCFD8DC)], // Solid gradient
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      scale = 1.02;
    } else if (rank == 3) {
      // Bronze styling
      rankColor = const Color.fromARGB(255, 146, 68, 4); // Darker Bronze
      textColor = Colors.white; // White text for dark bronze
      glowColor = Colors.brown;
      borderGradient = const LinearGradient(
        colors: [Color(0xFFCD7F32), Color(0xFFA0522D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      bgGradient = const LinearGradient(
        colors: [Color(0xFFCD7F32), Color(0xFFA0522D)], // Solid gradient
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      rankColor = theme.colorScheme.onSurface.withValues(alpha: 0.5);
      textColor = theme.colorScheme.onSurface;
      glowColor = null;
      borderGradient = null;
      bgGradient = null;
    }

    return Transform.scale(
      scale: scale,
      child: Container(
        height: isTop3 ? 80 : 70,
        decoration: BoxDecoration(
          color: isTop3
              ? null
              : theme.colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          gradient: bgGradient,
          border: isTop3
              ? null
              : Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                ),
          boxShadow: isTop3
              ? [
                  BoxShadow(
                    color: glowColor!.withValues(alpha: 0.4), // Stronger glow
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Border for Top 3 (Overlay to add depth/shine)
            if (isTop3)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: Colors.transparent, // Placeholder
                  ),
                  gradient: borderGradient, // Does not work directly on border
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Rank
                  SizedBox(
                    width: 40,
                    child: isTop3
                        ? _buildTrophy(rank)
                        : Text(
                            '#$rank',
                            style: TextStyle(
                              color: isTop3 ? textColor : rankColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),

                  const SizedBox(width: 16),

                  // Avatar/Icon
                  if (rank > 3)
                    const SizedBox(width: 44, height: 44)
                  else
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        boxShadow: [
                          BoxShadow(
                            color: glowColor!.withValues(alpha: 0.2),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        rank == 1 ? '👑' : (rank == 2 ? '🥈' : '🥉'),
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),

                  const SizedBox(width: 16),

                  // Name and Date
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.displayName.trim().contains(' ')
                              ? '${entry.displayName.trim().split(' ').first} ${entry.displayName.trim().split(' ').last[0]}.'
                              : entry.displayName,
                          style: TextStyle(
                            color: isTop3
                                ? textColor
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _formatDate(entry.timestamp),
                          style: TextStyle(
                            color: isTop3
                                ? textColor.withValues(alpha: 0.7)
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isTop3
                          ? Colors.black.withValues(
                              alpha: 0.1,
                            ) // Subtle dark bg for score
                          : theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entry.score}',
                      style: TextStyle(
                        color: isTop3 ? textColor : accentColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: -0.5,
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
  }

  Widget _buildTrophy(int rank) {
    Color color;
    if (rank == 1) {
      color = const Color(0xFFFFD700);
    } else if (rank == 2) {
      color = const Color(0xFFC0C0C0);
    } else {
      color = const Color(0xFFCD7F32);
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: rank == 1
            ? Colors.white.withValues(alpha: 0.3)
            : color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$rank',
        style: TextStyle(
          color: rank == 1 ? const Color(0xFF3E2723) : color,
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
