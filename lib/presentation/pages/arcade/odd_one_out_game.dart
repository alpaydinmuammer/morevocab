import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/challenge_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import 'widgets/game_over_screen.dart';
import 'widgets/arcade_stat_card.dart';
import 'odd_one_out_questions.dart';

/// Odd One Out Game - Find the word that doesn't belong
class OddOneOutGame extends ConsumerStatefulWidget {
  const OddOneOutGame({super.key});

  @override
  ConsumerState<OddOneOutGame> createState() => _OddOneOutGameState();
}

class _OddOneOutGameState extends ConsumerState<OddOneOutGame> {
  int _currentIndex = 0;
  List<String> _currentWords = [];
  int _currentOddIndex = 0;

  int? _selectedIndex;
  bool _answered = false;

  @override
  @override
  void initState() {
    super.initState();
    // Load saved level
    final savedLevel = ref
        .read(arcadeHighScoresProvider)
        .getLevel(ArcadeGameType.oddOneOut);

    if (savedLevel < _questions.length) {
      _currentIndex = savedLevel;
    } else {
      _currentIndex = 0;
    }

    // Shuffle options for the current question only when needed, not all at once
    _prepareCurrentQuestion();
  }

  void _prepareCurrentQuestion() {
    // Create a mutable copy of words to shuffle functionality
    // Since OddOneOutQuestion is immutable, we create local variables for current display
    _currentWords = List.from(_questions[_currentIndex].words);
    // Find the odd word string based on original index
    final oddWord =
        _questions[_currentIndex].words[_questions[_currentIndex].oddIndex];

    // Shuffle the display words
    _currentWords.shuffle();

    // Find the new index of the odd word
    _currentOddIndex = _currentWords.indexOf(oddWord);
  }

  final List<OddOneOutQuestion> _questions = OddOneOutQuestions.questions;

  OddOneOutQuestion get _current => _questions[_currentIndex];

  void _selectWord(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _currentOddIndex) {
        // Save progress immediately
        final nextLevel = _currentIndex + 1;
        ref
            .read(arcadeHighScoresProvider.notifier)
            .updateLevel(ArcadeGameType.oddOneOut, nextLevel);

        // Update challenge progress
        ref
            .read(challengesProvider.notifier)
            .checkProgress(ArcadeGameType.oddOneOut, newLevel: nextLevel);

        // Record activity for streak
        ref.read(streakProvider.notifier).recordActivity();
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted && _currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedIndex = null;
          _answered = false;
          _prepareCurrentQuestion();
        });
      } else if (mounted) {
        _showComplete();
      }
    });
  }

  void _showComplete() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          gameId: 'oddOneOut',
          score: 0,
          highScore: 0,
          showScore: false,
          accentColor: Colors.deepPurple,
          extraStats: [
            GameOverStat(
              label: 'Total Questions',
              value: '${_questions.length}',
            ),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            setState(() {
              _currentIndex = 0;
              _selectedIndex = null;
              _answered = false;
              _prepareCurrentQuestion();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
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
                        Text(
                          l10n.gameOddOneOut,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ArcadeStatCard(
                          label: 'Level',
                          value: '${_currentIndex + 1}/${_questions.length}',
                          icon: Icons.flag_rounded,
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Question
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Which one doesn\'t belong?',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Word options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2,
                      children: List.generate(
                        4,
                        (index) => _buildWordCard(theme, index),
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),
                ],
              ),

              // Explanation (overlay at bottom)
              if (_answered)
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == _currentOddIndex
                          ? Colors.green.withValues(alpha: 0.2)
                          : Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _selectedIndex == _currentOddIndex
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _selectedIndex == _currentOddIndex
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _current.explanation,
                            style: theme.textTheme.bodyMedium,
                          ),
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

  Widget _buildWordCard(ThemeData theme, int index) {
    // Ensure we have words to display
    if (_currentWords.isEmpty) return const SizedBox();

    final word = _currentWords[index];
    final isOdd = index == _currentOddIndex;
    final isSelected = _selectedIndex == index;

    Color bgColor = theme.colorScheme.surface;
    Color borderColor = theme.colorScheme.outline.withValues(alpha: 0.3);

    if (_answered) {
      if (isOdd) {
        bgColor = Colors.green.withValues(alpha: 0.2);
        borderColor = Colors.green;
      } else if (isSelected) {
        bgColor = Colors.red.withValues(alpha: 0.2);
        borderColor = Colors.red;
      }
    } else if (isSelected) {
      borderColor = Colors.deepPurple;
    }

    return GestureDetector(
      onTap: () => _selectWord(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            word,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
