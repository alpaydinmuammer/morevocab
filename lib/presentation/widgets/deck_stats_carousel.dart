import 'dart:math';
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
    // Use Random for better variety and center the initial page in the large range
    final random = Random();
    final randomOffset = random.nextInt(_decks.length);
    // Start around the middle of the range (10000) to allow infinite feel in both directions
    final middle = 5000;
    // Adjust middle to align with a random deck index
    final initialPage = middle - (middle % _decks.length) + randomOffset;

    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: initialPage,
    );
    _currentPage = initialPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: _pageController,
        // Using a very large number for infinite feel
        itemCount: 10000,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          // Map global index to deck index
          final deck = _decks[index % _decks.length];
          final isCurrent = _currentPage == index;

          return AnimatedScale(
            scale: isCurrent ? 1.0 : 0.9,
            duration: const Duration(milliseconds: 300),
            child: DeckCard(
              deck: deck,
              isFocused: isCurrent,
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
