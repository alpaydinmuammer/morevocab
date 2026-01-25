import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import '../../domain/models/word_deck.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/premium_background.dart';
import '../widgets/deck_card.dart';
import '../providers/word_providers.dart';
import '../providers/error_log_provider.dart';

class DeckSelectionPage extends ConsumerStatefulWidget {
  const DeckSelectionPage({super.key});

  @override
  ConsumerState<DeckSelectionPage> createState() => _DeckSelectionPageState();
}

class _DeckSelectionPageState extends ConsumerState<DeckSelectionPage> {
  late Map<WordDeck, int> _deckCounts;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    final repository = ref.read(wordRepositoryProvider);
    final deckCountsResult = repository.getAllDeckCounts();

    setState(() {
      _deckCounts = deckCountsResult.valueOrNull ?? {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Reordered decks: examStrategies first, then others (excluding custom)
    final otherDecks = WordDeck.values
        .where((d) => d != WordDeck.custom && d != WordDeck.examStrategies)
        .toList();

    // Build order: examStrategies (0), errorLog (1), mixed (2), ...rest
    // Total items: 1 (examStrategies) + 1 (errorLog) + otherDecks.length + 1 (coming soon)
    final totalItems = 1 + 1 + otherDecks.length + 1;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.selectDeck,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: PremiumBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.whichDeckIntro,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(36, 0, 36, 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.80,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    // Position 0: examStrategies (first deck)
                    if (index == 0) {
                      final deck = WordDeck.examStrategies;
                      return DeckCard(
                        deck: deck,
                        showProgress: false,
                        showDescription: true,
                        showWordCount: true,
                        wordCount: _deckCounts[deck] ?? 0,
                        onTap: () {
                          context.push('/swipe', extra: deck);
                        },
                      );
                    }
                    // Position 1: Error Log card (second)
                    if (index == 1) {
                      return _buildErrorLogCard(context, theme, ref);
                    }
                    // Positions 2 to (2 + otherDecks.length - 1): remaining decks
                    final deckIndex =
                        index - 2; // offset for examStrategies and error log
                    if (deckIndex < otherDecks.length) {
                      final deck = otherDecks[deckIndex];
                      return DeckCard(
                        deck: deck,
                        showProgress: false,
                        showDescription: true,
                        showWordCount: true,
                        wordCount: _deckCounts[deck] ?? 0,
                        onTap: () {
                          context.push('/swipe', extra: deck);
                        },
                      );
                    }
                    // Last position: Coming Soon card
                    return _buildCreateDeckCard(theme);
                  }, childCount: totalItems),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateDeckCard(ThemeData theme) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primaryContainer.withValues(alpha: 0.8),
                theme.colorScheme.primary.withValues(alpha: 0.3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              // Blurred content (everything except lock)
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Stack(
                  children: [
                    // Background decoration
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(
                        Icons.add_circle_rounded,
                        size: 120,
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                    ),

                    // Content - only icon, no text (text is below lock now)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Note: Text moved below lock - removed from blur
                  ],
                ),
              ),

              // Lock overlay (NOT blurred) - positioned higher
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      Icons.lock_rounded,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // "Coming Soon" Badge (below lock)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppLocalizations.of(context)!.comingSoon,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorLogCard(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final errorLogState = ref.watch(errorLogProvider);
    final entryCount = errorLogState.totalEntries;

    return GestureDetector(
      onTap: () => context.push('/error-log'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red.shade600, Colors.orange.shade700],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background image
              Positioned(
                right: -10,
                bottom: -10,
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                    'assets/images/decks/error_log.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Centered logo
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image.asset(
                              'assets/images/decks/error_log.png',
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Title
                    AutoSizeText(
                      l10n.errorLogTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Description
                    const SizedBox(height: 4),
                    Text(
                      l10n.errorLogCardDesc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Entry count badge
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
                        '$entryCount ${entryCount == 1 ? 'word' : 'words'}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
