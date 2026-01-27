import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/badge_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/badges_modal.dart';
import 'widgets/arcade_leaderboard_screen.dart';

/// Arcade mode hub page displaying all available mini-games
class ArcadeHubPage extends ConsumerStatefulWidget {
  const ArcadeHubPage({super.key});

  @override
  ConsumerState<ArcadeHubPage> createState() => _ArcadeHubPageState();
}

class _ArcadeHubPageState extends ConsumerState<ArcadeHubPage> {
  @override
  void initState() {
    super.initState();
    // Check for newly unlocked badges after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBadges();
    });
  }

  Future<void> _checkBadges() async {
    final arcadeState = ref.read(arcadeHighScoresProvider);
    final streakState = ref.read(streakProvider);

    final newlyUnlocked = await ref
        .read(badgeProvider.notifier)
        .checkAndUnlockBadges(
          arcadeState: arcadeState,
          streakState: streakState,
        );

    // Show popup for each newly unlocked badge
    if (mounted && newlyUnlocked.isNotEmpty) {
      for (final badge in newlyUnlocked) {
        if (!mounted) break;
        await BadgeUnlockDialog.show(context, badge);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final highScores = ref.watch(arcadeHighScoresProvider);

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLG),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingLG),
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.arcadeTitle,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            l10n.arcadeSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingLG),
                    // Leaderboard Button
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.leaderboard_rounded),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ArcadeLeaderboardScreen(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Games Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingLG,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppConstants.spacingLG,
                    crossAxisSpacing: AppConstants.spacingLG,
                    childAspectRatio: 0.85,
                    children: [
                      _ArcadeGameCard(
                        imagePath: 'assets/images/arcade/word_chain.png',
                        title: l10n.gameWordChain,
                        description: l10n.gameWordChainDesc,
                        accentColor: Colors.orange,
                        highScore: highScores.getScore(
                          ArcadeGameType.wordChain,
                        ),
                        onTap: () => context.push('/arcade/word-chain'),
                      ),
                      _ArcadeGameCard(
                        imagePath: 'assets/images/arcade/anagram.png',
                        title: l10n.gameAnagram,
                        description: l10n.gameAnagramDesc,
                        accentColor: Colors.teal,
                        highScore: 0,
                        level: highScores.getLevel(ArcadeGameType.anagram),
                        onTap: () => context.push('/arcade/anagram'),
                      ),
                      _ArcadeGameCard(
                        imagePath: 'assets/images/arcade/word_builder.png',
                        title: l10n.gameWordBuilder,
                        description: l10n.gameWordBuilderDesc,
                        accentColor: Colors.indigo,
                        highScore: 0,
                        level: highScores.getLevel(ArcadeGameType.wordBuilder),
                        onTap: () => context.push('/arcade/word-builder'),
                      ),
                      _ArcadeGameCard(
                        imagePath: 'assets/images/arcade/emoji_puzzle.png',
                        title: l10n.gameEmojiPuzzle,
                        description: l10n.gameEmojiPuzzleDesc,
                        accentColor: Colors.pink,
                        highScore: 0,
                        level: highScores.getLevel(ArcadeGameType.emojiPuzzle),
                        onTap: () => context.push('/arcade/emoji-puzzle'),
                      ),
                      _ArcadeGameCard(
                        imagePath: 'assets/images/arcade/odd_one_out.png',
                        title: l10n.gameOddOneOut,
                        description: l10n.gameOddOneOutDesc,
                        accentColor: Colors.deepPurple,
                        highScore: 0,
                        level: highScores.getLevel(ArcadeGameType.oddOneOut),
                        onTap: () => context.push('/arcade/odd-one-out'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcadeGameCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color accentColor;
  final int highScore;
  final int? level;
  final VoidCallback? onTap;

  const _ArcadeGameCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.highScore,
    this.level,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedPressable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [accentColor, accentColor.withValues(alpha: 0.7)],
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background image decoration
              Positioned(
                right: -10,
                bottom: -10,
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // High Score Badge (Top Right)
              if (highScore > 0 || (level != null && level! > 0))
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          level != null
                              ? Icons.flag_rounded
                              : Icons.emoji_events_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          level != null ? 'Lvl ${level! + 1}' : '$highScore',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    // Central Image
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            imagePath,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Title
                    AutoSizeText(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      minFontSize: 12,
                      stepGranularity: 0.5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Description
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
