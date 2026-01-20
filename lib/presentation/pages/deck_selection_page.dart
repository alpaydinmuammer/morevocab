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
  List<String> _customDecks = [];
  Map<String, int> _customDeckCounts = {};

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final repository = ref.read(wordRepositoryProvider);

    final deckCountsResult = repository.getAllDeckCounts();
    final customDecksResult = repository.getCustomDeckNames();

    final customDecks = customDecksResult.valueOrNull ?? [];

    // Calculate custom deck counts
    final customDeckCounts = <String, int>{};
    if (customDecks.isNotEmpty) {
      final wordsResult = await repository.getWordsByDeck(WordDeck.custom);
      wordsResult.when(
        success: (words) {
          for (final deckName in customDecks) {
            customDeckCounts[deckName] =
                words.where((w) => w.customDeckName == deckName).length;
          }
        },
        failure: (_) {},
      );
    }

    setState(() {
      _deckCounts = deckCountsResult.valueOrNull ?? {};
      _customDecks = customDecks;
      _customDeckCounts = customDeckCounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1. Standard decks (excluding custom placeholder)
    final standardDecks = WordDeck.values
        .where((d) => d != WordDeck.custom)
        .toList();

    // Total items: Standard Decks + Custom Decks + Create Button
    final totalItems = standardDecks.length + _customDecks.length + 1;

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
            padding: const EdgeInsets.all(20),
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
                      // Case 1: Standard Decks
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

                      // Case 2: Custom Decks
                      final customIndex = index - standardDecks.length;
                      if (customIndex < _customDecks.length) {
                        final deckName = _customDecks[customIndex];
                        final customCount = _customDeckCounts[deckName] ?? 0;

                        return DeckCard(
                          deck: WordDeck.custom, // Base style
                          customTitle: deckName, // NEW param needed in DeckCard
                          showProgress: false,
                          showDescription: false,
                          showWordCount: true,
                          wordCount: customCount,
                          onTap: () {
                            // Pass custom logic.
                            // We might need to change /swipe to accept a generic object or extra params
                            // For now, let's pass a Map or special object
                            context.push('/custom-deck', extra: deckName);
                          },
                        );
                      }

                      // Case 3: Create New Deck Button
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
                          color: theme.colorScheme.primary.withValues(alpha: 0.9),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.4),
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
