import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/word_deck.dart';

import 'deck_card.dart';
import 'deck_word_list_modal.dart';

class DeckStatsCarousel extends ConsumerStatefulWidget {
  const DeckStatsCarousel({super.key});

  @override
  ConsumerState<DeckStatsCarousel> createState() => _DeckStatsCarouselState();
}

class _DeckStatsCarouselState extends ConsumerState<DeckStatsCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  // Define the decks to show in the carousel
  final List<WordDeck> _decks = [
    WordDeck.ydsYdt,
    WordDeck.beginner,
    WordDeck.survival,
    WordDeck.phrasalVerbs,
    WordDeck.idioms,
    WordDeck.examStrategies,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Fixed height for carousel
      child: PageView.builder(
        controller: _pageController,
        itemCount: _decks.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final deck = _decks[index];
          // Calculate scale for current item
          // Simple scale effect based on position (can be enhanced)
          return AnimatedScale(
            scale: _currentPage == index ? 1.0 : 0.9,
            duration: const Duration(milliseconds: 300),
            child: DeckCard(
              deck: deck,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: DeckWordListModal(deck: deck),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
