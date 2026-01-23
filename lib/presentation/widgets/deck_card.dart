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
      child: Container(
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
          children: [
            // Background Icon decoration
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                deck.icon,
                size: 100,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // NEW badge for strategy deck (only if showing details/description)
            if (isStrategy && showDescription)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 12,
                        color: const Color(0xFF00838F),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context)!.newLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF00838F),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deck Icon and Name
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          deck.icon,
                          color: Colors.white,
                          size: showProgress ? 26 : 20, // Tweaked icon size
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          customTitle ?? deck.getLocalizedName(context),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: showProgress
                                ? 20
                                : 16, // Tweaked title size
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Description
                  if (showDescription) ...[
                    Text(
                      deck.getLocalizedDescription(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.95),
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Word Count Badge (Grid only usually)
                  if (showWordCount && wordCount != null)
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
                                fontSize: 50, // Tweaked percentage
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${stats.knownWords} / ${stats.totalWords} ${AppLocalizations.of(context)!.learned}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w600,
                                fontSize: 16, // Bigger learned text
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Progress Bar
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
                                minHeight: 12, // Thicker bar
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
    );
  }
}
