import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../widgets/premium_background.dart';

/// Arcade mode hub page displaying all available mini-games
class ArcadeHubPage extends ConsumerWidget {
  const ArcadeHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: const EdgeInsets.all(16),
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
                    const SizedBox(width: 16),
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
                  ],
                ),
              ),

              // Games Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      _ArcadeGameCard(
                        emoji: '🔗',
                        title: l10n.gameWordChain,
                        description: l10n.gameWordChainDesc,
                        accentColor: Colors.orange,
                        highScore: highScores.getScore(
                          ArcadeGameType.wordChain,
                        ),
                        onTap: () => context.push('/arcade/word-chain'),
                      ),
                      _ArcadeGameCard(
                        emoji: '🔤',
                        title: l10n.gameAnagram,
                        description: l10n.gameAnagramDesc,
                        accentColor: Colors.teal,
                        highScore: highScores.getScore(ArcadeGameType.anagram),
                        onTap: () => context.push('/arcade/anagram'),
                      ),
                      _ArcadeGameCard(
                        emoji: '🏗️',
                        title: l10n.gameWordBuilder,
                        description: l10n.gameWordBuilderDesc,
                        accentColor: Colors.indigo,
                        highScore: highScores.getScore(
                          ArcadeGameType.wordBuilder,
                        ),
                        onTap: () => context.push('/arcade/word-builder'),
                      ),
                      _ArcadeGameCard(
                        emoji: '😀',
                        title: l10n.gameEmojiPuzzle,
                        description: l10n.gameEmojiPuzzleDesc,
                        accentColor: Colors.pink,
                        highScore: highScores.getScore(
                          ArcadeGameType.emojiPuzzle,
                        ),
                        onTap: () => context.push('/arcade/emoji-puzzle'),
                      ),
                      _ArcadeGameCard(
                        emoji: '🎯',
                        title: l10n.gameOddOneOut,
                        description: l10n.gameOddOneOutDesc,
                        accentColor: Colors.deepPurple,
                        highScore: highScores.getScore(
                          ArcadeGameType.oddOneOut,
                        ),
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
  final String emoji;
  final String title;
  final String description;
  final Color accentColor;
  final int highScore;
  final VoidCallback? onTap;

  const _ArcadeGameCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.highScore,
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
        child: Stack(
          children: [
            // Background emoji decoration
            Positioned(
              right: -10,
              bottom: -10,
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),

            // High Score Badge (Top Right)
            if (highScore > 0)
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
                      const Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$highScore',
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
                  // Central Emoji
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(emoji, style: const TextStyle(fontSize: 42)),
                    ),
                  ),
                  const Spacer(),
                  // Title
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    maxLines: 1,
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
    );
  }
}
