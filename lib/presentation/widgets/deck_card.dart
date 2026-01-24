import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/word_deck.dart';
import '../providers/word_providers.dart';
import '../../l10n/app_localizations.dart';
import 'premium_background.dart';

class DeckCard extends ConsumerWidget {
  final WordDeck deck;
  final VoidCallback onTap;
  final bool showProgress;
  final bool showDescription;
  final bool showWordCount;
  final int? wordCount;
  final String? customTitle;
  final bool isFocused; // NEW: for carousel focus effect

  const DeckCard({
    super.key,
    required this.deck,
    required this.onTap,
    this.showProgress = true,
    this.showDescription = false,
    this.showWordCount = false,
    this.wordCount,
    this.customTitle,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch stats if we show progress to avoid unnecessary rebuilds if unrelated
    final statsAsync = showProgress ? ref.watch(deckStatsProvider(deck)) : null;
    final theme = Theme.of(context);

    // New badge for strategy deck
    final isStrategy = deck == WordDeck.examStrategies;

    return AnimatedPressable(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The Card Body
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [deck.color, deck.color.withValues(alpha: 0.7)],
              ),
              boxShadow: [
                BoxShadow(
                  color: deck.color.withValues(alpha: isFocused ? 0.5 : 0.3),
                  blurRadius: isFocused ? 20 : 12,
                  offset: Offset(0, isFocused ? 10 : 8),
                  spreadRadius: isFocused ? 2 : 0,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background decoration (Icon for home, Image for deck selection)
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: showProgress
                      // Home page: use icon
                      ? Icon(
                          deck.icon,
                          size: 100,
                          color: Colors.white.withValues(alpha: 0.1),
                        )
                      // Deck selection: use image if available
                      : deck.imagePath != null
                      ? Opacity(
                          opacity: 0.08,
                          child: Image.asset(
                            deck.imagePath!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Icon(
                          deck.icon,
                          size: 100,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                ),

                Padding(
                  padding: EdgeInsets.all(showProgress ? 16 : 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Different layout based on showProgress
                      if (showProgress) ...[
                        // HOME PAGE LAYOUT: Small logo top-left with title
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: deck.imagePath != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        deck.imagePath!,
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      deck.icon,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                customTitle ?? deck.getLocalizedName(context),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ] else ...[
                        // DECK SELECTION LAYOUT: Centered logo
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: deck.imagePath != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        deck.imagePath!,
                                        width: 65,
                                        height: 65,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      deck.icon,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                            ),
                          ),
                        ),

                        // Title (for deck selection)
                        Text(
                          customTitle ?? deck.getLocalizedName(context),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Description
                      if (showDescription) ...[
                        const SizedBox(height: 4),
                        Text(
                          deck.getLocalizedDescription(context),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                            height: 1.1,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Word Count Badge
                      if (showWordCount && wordCount != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isStrategy
                                ? AppLocalizations.of(
                                    context,
                                  )!.strategiesCount(wordCount!)
                                : AppLocalizations.of(
                                    context,
                                  )!.deckWordCount(wordCount!),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],

                      // Stats Content
                      if (showProgress && statsAsync != null)
                        statsAsync.when(
                          data: (stats) {
                            final progress = stats.totalWords > 0
                                ? (stats.knownWords / stats.totalWords)
                                : 0.0;
                            final percentage = (progress * 100).toInt();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$percentage%',
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 42,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${stats.knownWords} / ${stats.totalWords} ${AppLocalizations.of(context)!.learned}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.white.withValues(
                                      alpha: 0.2,
                                    ),
                                    valueColor: const AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          error: (_, _) => const SizedBox(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // NEW badge (moved outside the card container)
          if (isStrategy && showDescription)
            Positioned(
              top: -12,
              right: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: const Color(0xFF00838F),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.newLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF00838F),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
