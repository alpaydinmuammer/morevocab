import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../domain/models/word_deck.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/premium_background.dart';
import '../widgets/deck_card.dart';
import '../providers/word_providers.dart';

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

    // Standard decks (excluding custom placeholder)
    final standardDecks = WordDeck.values
        .where((d) => d != WordDeck.custom)
        .toList();

    // Total items: Standard Decks + Create Button (Coming Soon)
    final totalItems = standardDecks.length + 1;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      extendBodyBehindAppBar: true,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.whichDeckIntro,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.builder(
                    clipBehavior: Clip.none,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio:
                              0.85, // Taller cards for better info
                        ),
                    itemCount: totalItems,
                    itemBuilder: (context, index) {
                      // Standard Decks
                      if (index < standardDecks.length) {
                        final deck = standardDecks[index];
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

                      // Create New Deck Button (Coming Soon)
                      return _buildCreateDeckCard(theme);
                    },
                  ),
                ),
              ],
            ),
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
}
