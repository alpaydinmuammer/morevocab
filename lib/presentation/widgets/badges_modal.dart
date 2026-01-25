import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/badge_model.dart';
import '../../l10n/app_localizations.dart';
import '../providers/badge_provider.dart';

/// Modal showing all badges in a grid
class BadgesModal extends ConsumerWidget {
  const BadgesModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BadgesModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final badgeState = ref.watch(badgeProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text('🏅', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.badges,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${badgeState.unlockedCount} / ${BadgeDefinitions.all.length}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),

            // Badge grid
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      context,
                      l10n.badgeSectionAnagram,
                      [
                        BadgeType.anagramRookie,
                        BadgeType.anagramExpert,
                        BadgeType.anagramChampion,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionWordChain,
                      [
                        BadgeType.chainStarter,
                        BadgeType.chainMaster,
                        BadgeType.chainLegend,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionOddOneOut,
                      [
                        BadgeType.observer,
                        BadgeType.detective,
                        BadgeType.sharpshooter,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionEmojiPuzzle,
                      [
                        BadgeType.emojiSolver,
                        BadgeType.puzzleMaster,
                        BadgeType.emojiLegend,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionWordBuilder,
                      [
                        BadgeType.wordWorker,
                        BadgeType.wordArchitect,
                        BadgeType.wordKing,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionStreak,
                      [
                        BadgeType.fireSpirit,
                        BadgeType.dedicated,
                        BadgeType.legendary,
                      ],
                      badgeState,
                      l10n,
                    ),
                    _buildSection(
                      context,
                      l10n.badgeSectionSpecial,
                      [
                        BadgeType.firstStep,
                        BadgeType.arcadeFan,
                        BadgeType.brainBoss,
                      ],
                      badgeState,
                      l10n,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<BadgeType> badges,
    BadgeState badgeState,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: badges.map((type) {
              return Expanded(
                child: _BadgeCard(
                  type: type,
                  isUnlocked: badgeState.isUnlocked(type),
                  l10n: l10n,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final BadgeType type;
  final bool isUnlocked;
  final AppLocalizations l10n;

  const _BadgeCard({
    required this.type,
    required this.isUnlocked,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badge = BadgeDefinitions.getByType(type);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUnlocked
              ? _getTierColor(badge.tier).withValues(alpha: 0.15)
              : theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
          borderRadius: BorderRadius.circular(16),
          border: isUnlocked
              ? Border.all(
                  color: _getTierColor(badge.tier).withValues(alpha: 0.5),
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon - larger size
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  badge.icon,
                  style: TextStyle(
                    fontSize: 40,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                ),
                if (!isUnlocked)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_rounded,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              _getBadgeName(type, l10n),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isUnlocked
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Requirement
            Text(
              _getRequirementText(type, l10n),
              style: theme.textTheme.labelSmall?.copyWith(
                color: isUnlocked
                    ? Colors.green.shade600
                    : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getRequirementText(BadgeType type, AppLocalizations l10n) {
    switch (type) {
      // Anagram (Level-based)
      case BadgeType.anagramRookie:
        return 'Level 5';
      case BadgeType.anagramExpert:
        return 'Level 15';
      case BadgeType.anagramChampion:
        return 'Level 30';
      // Word Chain (Score-based) - harder
      case BadgeType.chainStarter:
        return '500 ${l10n.score}';
      case BadgeType.chainMaster:
        return '1000 ${l10n.score}';
      case BadgeType.chainLegend:
        return '1500 ${l10n.score}';
      // Odd One Out (Score-based) - harder
      case BadgeType.observer:
        return '100 ${l10n.score}';
      case BadgeType.detective:
        return '250 ${l10n.score}';
      case BadgeType.sharpshooter:
        return '500 ${l10n.score}';
      // Emoji Puzzle (Level-based)
      case BadgeType.emojiSolver:
        return 'Level 10';
      case BadgeType.puzzleMaster:
        return 'Level 20';
      case BadgeType.emojiLegend:
        return 'Level 30';
      // Word Builder (Score-based) - harder
      case BadgeType.wordWorker:
        return '100 ${l10n.score}';
      case BadgeType.wordArchitect:
        return '250 ${l10n.score}';
      case BadgeType.wordKing:
        return '500 ${l10n.score}';
      // Streak - harder
      case BadgeType.fireSpirit:
        return '7 🔥';
      case BadgeType.dedicated:
        return '30 🔥';
      case BadgeType.legendary:
        return '100 🔥';
      // Special - based on total badges
      case BadgeType.firstStep:
        return '5 rozet';
      case BadgeType.arcadeFan:
        return '10 rozet';
      case BadgeType.brainBoss:
        return '20 rozet';
    }
  }

  Color _getTierColor(BadgeTier tier) {
    switch (tier) {
      case BadgeTier.bronze:
        return Colors.orange.shade700;
      case BadgeTier.silver:
        return Colors.blueGrey.shade400;
      case BadgeTier.gold:
        return Colors.amber.shade600;
      case BadgeTier.special:
        return Colors.purple;
    }
  }

  String _getBadgeName(BadgeType type, AppLocalizations l10n) {
    switch (type) {
      case BadgeType.anagramRookie:
        return l10n.badgeAnagramRookie;
      case BadgeType.anagramExpert:
        return l10n.badgeAnagramExpert;
      case BadgeType.anagramChampion:
        return l10n.badgeAnagramChampion;
      case BadgeType.chainStarter:
        return l10n.badgeChainStarter;
      case BadgeType.chainMaster:
        return l10n.badgeChainMaster;
      case BadgeType.chainLegend:
        return l10n.badgeChainLegend;
      case BadgeType.observer:
        return l10n.badgeObserver;
      case BadgeType.detective:
        return l10n.badgeDetective;
      case BadgeType.sharpshooter:
        return l10n.badgeSharpshooter;
      case BadgeType.emojiSolver:
        return l10n.badgeEmojiSolver;
      case BadgeType.puzzleMaster:
        return l10n.badgePuzzleMaster;
      case BadgeType.emojiLegend:
        return l10n.badgeEmojiLegend;
      case BadgeType.wordWorker:
        return l10n.badgeWordWorker;
      case BadgeType.wordArchitect:
        return l10n.badgeWordArchitect;
      case BadgeType.wordKing:
        return l10n.badgeWordKing;
      case BadgeType.fireSpirit:
        return l10n.badgeFireSpirit;
      case BadgeType.dedicated:
        return l10n.badgeDedicated;
      case BadgeType.legendary:
        return l10n.badgeLegendary;
      case BadgeType.firstStep:
        return l10n.badgeFirstStep;
      case BadgeType.arcadeFan:
        return l10n.badgeArcadeFan;
      case BadgeType.brainBoss:
        return l10n.badgeBrainBoss;
    }
  }
}

/// Simple popup dialog for badge unlock notification
class BadgeUnlockDialog extends StatelessWidget {
  final BadgeType badgeType;

  const BadgeUnlockDialog({super.key, required this.badgeType});

  static Future<void> show(BuildContext context, BadgeType type) {
    return showDialog(
      context: context,
      builder: (context) => BadgeUnlockDialog(badgeType: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final badge = BadgeDefinitions.getByType(badgeType);

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebration icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getTierColor(badge.tier).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(badge.icon, style: const TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.badgeUnlocked,
              style: theme.textTheme.titleMedium?.copyWith(
                color: _getTierColor(badge.tier),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getBadgeName(badgeType, l10n),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTierColor(BadgeTier tier) {
    switch (tier) {
      case BadgeTier.bronze:
        return Colors.orange.shade700;
      case BadgeTier.silver:
        return Colors.blueGrey.shade400;
      case BadgeTier.gold:
        return Colors.amber.shade600;
      case BadgeTier.special:
        return Colors.purple;
    }
  }

  String _getBadgeName(BadgeType type, AppLocalizations l10n) {
    switch (type) {
      case BadgeType.anagramRookie:
        return l10n.badgeAnagramRookie;
      case BadgeType.anagramExpert:
        return l10n.badgeAnagramExpert;
      case BadgeType.anagramChampion:
        return l10n.badgeAnagramChampion;
      case BadgeType.chainStarter:
        return l10n.badgeChainStarter;
      case BadgeType.chainMaster:
        return l10n.badgeChainMaster;
      case BadgeType.chainLegend:
        return l10n.badgeChainLegend;
      case BadgeType.observer:
        return l10n.badgeObserver;
      case BadgeType.detective:
        return l10n.badgeDetective;
      case BadgeType.sharpshooter:
        return l10n.badgeSharpshooter;
      case BadgeType.emojiSolver:
        return l10n.badgeEmojiSolver;
      case BadgeType.puzzleMaster:
        return l10n.badgePuzzleMaster;
      case BadgeType.emojiLegend:
        return l10n.badgeEmojiLegend;
      case BadgeType.wordWorker:
        return l10n.badgeWordWorker;
      case BadgeType.wordArchitect:
        return l10n.badgeWordArchitect;
      case BadgeType.wordKing:
        return l10n.badgeWordKing;
      case BadgeType.fireSpirit:
        return l10n.badgeFireSpirit;
      case BadgeType.dedicated:
        return l10n.badgeDedicated;
      case BadgeType.legendary:
        return l10n.badgeLegendary;
      case BadgeType.firstStep:
        return l10n.badgeFirstStep;
      case BadgeType.arcadeFan:
        return l10n.badgeArcadeFan;
      case BadgeType.brainBoss:
        return l10n.badgeBrainBoss;
    }
  }
}
