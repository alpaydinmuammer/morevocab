import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../domain/models/word_deck.dart';
import '../../domain/models/pet_model.dart';
import '../providers/word_providers.dart';
import '../providers/pet_provider.dart';
import '../providers/streak_provider.dart';
import '../widgets/word_card_widget.dart';
import '../widgets/swipe_background_feedback.dart';
import '../widgets/premium_background.dart';
import '../widgets/swipe_session_complete.dart';
import '../../l10n/app_localizations.dart';

class WordSwipePage extends ConsumerStatefulWidget {
  final WordDeck deck;

  const WordSwipePage({super.key, this.deck = WordDeck.mixed});

  @override
  ConsumerState<WordSwipePage> createState() => _WordSwipePageState();
}

class _WordSwipePageState extends ConsumerState<WordSwipePage> {
  late CardSwiperController _cardController;
  double _swipeOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _cardController = CardSwiperController();
    // Load words for selected deck after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _swipeOffset = 0.0; // Reset swipe offset for new deck
      });
      ref.read(wordStudyProvider.notifier).loadWords(widget.deck);
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studyState = ref.watch(wordStudyProvider);
    final theme = Theme.of(context);

    if (studyState.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.loadingWords,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    if (studyState.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(studyState.error!, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(wordStudyProvider.notifier).reset(),
                child: Text(AppLocalizations.of(context)!.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (studyState.isSessionComplete) {
      return SwipeSessionComplete(
        state: studyState,
        onStudyAgain: () => ref.read(wordStudyProvider.notifier).reset(),
        onBackToHome: () => Navigator.of(context).pop(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by mesh
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedCounter(
              value: studyState.remainingCards,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.wordsRemainingLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PremiumBackground(
        child: Stack(
          children: [
            // 4. Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    // Progress indicator wrapper
                    Container(
                      height: 10,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: studyState.words.isEmpty
                                ? 0
                                : studyState.currentIndex /
                                      studyState.words.length,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primary.withValues(
                                      alpha: 0.6,
                                    ),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card Swiper
                    Expanded(
                      child: CardSwiper(
                        key: ValueKey(
                          'card_swiper_${studyState.currentDeck}_${theme.brightness}',
                        ),
                        controller: _cardController,
                        cardsCount: studyState.words.length,
                        initialIndex: studyState.currentIndex,
                        numberOfCardsDisplayed: 3,
                        scale: 0.9,
                        backCardOffset: const Offset(0, 30),
                        padding: const EdgeInsets.all(8),
                        onSwipe: _onSwipe,
                        cardBuilder:
                            (
                              context,
                              index,
                              horizontalOffsetPercentage,
                              verticalOffsetPercentage,
                            ) {
                              if (index >= studyState.words.length) {
                                return const SizedBox();
                              }

                              if (index == studyState.currentIndex) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (mounted &&
                                      _swipeOffset !=
                                          horizontalOffsetPercentage
                                              .toDouble()) {
                                    setState(() {
                                      _swipeOffset = horizontalOffsetPercentage
                                          .toDouble();
                                    });
                                  }
                                });
                              }

                              return WordCardWidget(
                                wordCard: studyState.words[index],
                                onSpeak: () =>
                                    _speakWord(studyState.words[index].word),
                              );
                            },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context,
                          Icons.arrow_back_rounded,
                          AppLocalizations.of(context)!.iDontKnow,
                          Colors.red,
                          () => _cardController.swipe(CardSwiperDirection.left),
                        ),
                        _buildActionButton(
                          context,
                          Icons.arrow_forward_rounded,
                          AppLocalizations.of(context)!.iKnow,
                          Colors.green,
                          () =>
                              _cardController.swipe(CardSwiperDirection.right),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Background Feedback (Above decor, below content padding if needed, but safe here)
            SwipeBackgroundFeedback(swipeOffset: _swipeOffset),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final notifier = ref.read(wordStudyProvider.notifier);
    final studyState = ref.read(wordStudyProvider);

    if (direction == CardSwiperDirection.right) {
      notifier.markCurrentAsKnown();

      // Add XP for correct answer (silently, no overlay)
      final currentWord = studyState.words[previousIndex];
      final xp = PetXpValues.forCorrectAnswer(
        difficulty: currentWord.difficulty,
      );
      ref.read(petProvider.notifier).addExperience(xp);
    } else if (direction == CardSwiperDirection.left) {
      notifier.markCurrentForReview();
    }

    // Record activity for streak on any meaningful swipe
    ref.read(streakProvider.notifier).recordActivity();

    setState(() {
      _swipeOffset = 0.0;
    });

    return true;
  }

  void _speakWord(String word) {
    final tts = ref.read(ttsProvider);
    tts.speak(word);
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        AnimatedPressable(
          onTap: onPressed,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.brightness == Brightness.dark
                  ? theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.9)
                  : theme.colorScheme.surface.withValues(alpha: 0.8),
              border: Border.all(
                color: color.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.3 : 0.15,
                ),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.2 : 0.1,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: Icon(icon, color: color, size: 32)),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: color.withValues(alpha: 0.8),
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
