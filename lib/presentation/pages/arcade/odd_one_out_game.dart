import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import 'widgets/game_over_screen.dart';
import 'widgets/arcade_stat_card.dart';

/// Odd One Out Game - Find the word that doesn't belong
class OddOneOutGame extends ConsumerStatefulWidget {
  const OddOneOutGame({super.key});

  @override
  ConsumerState<OddOneOutGame> createState() => _OddOneOutGameState();
}

class _OddOneOutGameState extends ConsumerState<OddOneOutGame> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _questions.shuffle();
    for (var q in _questions) {
      // Find old oddWord before shuffling words
      final oddWord = q.words[q.oddIndex];
      q.words.shuffle();
      // Update oddIndex after shuffle
      q.oddIndex = q.words.indexOf(oddWord);
    }
  }

  final List<_Question> _questions = [
    _Question(['Apple', 'Banana', 'Car', 'Orange'], 2, 'Car is not a fruit'),
    _Question(
      ['Happy', 'Joyful', 'Sad', 'Cheerful'],
      2,
      'Sad is opposite emotion',
    ),
    _Question(['Dog', 'Cat', 'Bird', 'Table'], 3, 'Table is not an animal'),
    _Question(['Red', 'Blue', 'Green', 'Chair'], 3, 'Chair is not a color'),
    _Question(['Run', 'Walk', 'Jump', 'Book'], 3, 'Book is not an action'),
    _Question(
      ['Monday', 'Tuesday', 'March', 'Friday'],
      2,
      'March is a month, not a day',
    ),
    _Question(
      ['Piano', 'Guitar', 'Violin', 'Hammer'],
      3,
      'Hammer is not an instrument',
    ),
    _Question(
      ['Doctor', 'Teacher', 'Engineer', 'Apple'],
      3,
      'Apple is not a profession',
    ),
    _Question(
      ['Whale', 'Shark', 'Dolphin', 'Lion'],
      3,
      'Lion lives on land, others in water',
    ),
    _Question(
      ['Cloud', 'Rain', 'Snow', 'Sand'],
      3,
      'Sand is part of the ground, others are weather',
    ),
    _Question(
      ['Square', 'Circle', 'Triangle', 'Blue'],
      3,
      'Blue is a color, others are shapes',
    ),
    _Question(
      ['Mars', 'Venus', 'Jupiter', 'Moon'],
      3,
      'Moon is a satellite, others are planets',
    ),
    _Question(
      ['Milk', 'Juice', 'Water', 'Bread'],
      3,
      'Bread is solid food, others are liquids',
    ),
    _Question(
      ['Pencil', 'Pen', 'Crayon', 'Paper'],
      3,
      'Paper is for writing on, others are tools for writing',
    ),
    _Question(
      ['Socks', 'Shoes', 'Boots', 'Hat'],
      3,
      'Hat is for the head, others are for feet',
    ),
    _Question(
      ['Ear', 'Eye', 'Nose', 'Hand'],
      3,
      'Hand is a limb, others are facial sense organs',
    ),
    _Question(
      ['Sun', 'Star', 'Lantern', 'Rock'],
      3,
      'Rock does not produce light',
    ),
    _Question(
      ['Bed', 'Sofa', 'Chair', 'Car'],
      3,
      'Car is a vehicle, others are furniture',
    ),
  ];

  _Question get _current => _questions[_currentIndex];

  void _selectWord(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _current.oddIndex) {
        _score += 50;
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
        });
      } else if (mounted) {
        _showComplete();
      }
    });
  }

  void _showComplete() {
    // Save high score
    final highScores = ref.read(arcadeHighScoresProvider);
    final previousHighScore = highScores.getScore(ArcadeGameType.oddOneOut);
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.oddOneOut, _score);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: _score,
          highScore: previousHighScore,
          accentColor: Colors.deepPurple,
          extraStats: [
            GameOverStat(
              label: 'Total Questions',
              value: '${_questions.length}',
            ),
            GameOverStat(label: 'Correct', value: '${_score ~/ 50}'),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            setState(() {
              _questions.shuffle();
              for (var q in _questions) {
                // Find old oddWord before shuffling words
                final oddWord = q.words[q.oddIndex];
                q.words.shuffle();
                // Update oddIndex after shuffle
                q.oddIndex = q.words.indexOf(oddWord);
              }
              _currentIndex = 0;
              _score = 0;
              _selectedIndex = null;
              _answered = false;
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
          child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArcadeStatCard(
                      label: 'Question',
                      value: '${_currentIndex + 1}/${_questions.length}',
                      icon: Icons.help_outline_rounded,
                      color: Colors.deepPurple,
                    ),
                    ArcadeStatCard(
                      label: l10n.score,
                      value: '$_score',
                      icon: Icons.stars_rounded,
                      color: Colors.orange,
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

              const SizedBox(height: 24),

              // Explanation (shown after answer)
              if (_answered)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _selectedIndex == _current.oddIndex
                        ? Colors.green.withValues(alpha: 0.2)
                        : Colors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedIndex == _current.oddIndex
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _selectedIndex == _current.oddIndex
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

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordCard(ThemeData theme, int index) {
    final word = _current.words[index];
    final isOdd = index == _current.oddIndex;
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

class _Question {
  final List<String> words;
  int oddIndex;
  final String explanation;
  _Question(this.words, this.oddIndex, this.explanation);
}
