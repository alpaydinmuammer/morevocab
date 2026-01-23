import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import 'widgets/game_over_screen.dart';
import 'widgets/arcade_stat_card.dart';

/// Word Builder Game - Build words from syllables based on definitions
class WordBuilderGame extends ConsumerStatefulWidget {
  const WordBuilderGame({super.key});

  @override
  ConsumerState<WordBuilderGame> createState() => _WordBuilderGameState();
}

class _WordBuilderGameState extends ConsumerState<WordBuilderGame> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<String> _selectedSyllables = [];

  @override
  void initState() {
    super.initState();
    _questions.shuffle();
    for (var q in _questions) {
      q.syllables.shuffle();
    }
  }

  // Expanded question set
  final List<_WordBuilderQuestion> _questions = [
    _WordBuilderQuestion(
      definition: 'A building where movies are shown.',
      syllables: ['NE', 'CI', 'MA'],
      answer: 'CINEMA',
    ),
    _WordBuilderQuestion(
      definition: 'A person who teaches students.',
      syllables: ['ER', 'TEACH'],
      answer: 'TEACHER',
    ),
    _WordBuilderQuestion(
      definition: 'A large body of salt water.',
      syllables: ['AN', 'OCE'],
      answer: 'OCEAN',
    ),
    _WordBuilderQuestion(
      definition: 'The meal you eat in the morning.',
      syllables: ['FAST', 'BREAK'],
      answer: 'BREAKFAST',
    ),
    _WordBuilderQuestion(
      definition: 'A device used to talk to people far away.',
      syllables: ['PHONE', 'TELE'],
      answer: 'TELEPHONE',
    ),
    _WordBuilderQuestion(
      definition: 'A tropical fruit with yellow skin.',
      syllables: ['NA', 'BA', 'NA'],
      answer: 'BANANA',
    ),
    _WordBuilderQuestion(
      definition: 'A machine that performs calculations.',
      syllables: ['TER', 'COM', 'PU'],
      answer: 'COMPUTER',
    ),
    _WordBuilderQuestion(
      definition: 'A large animal with a long trunk.',
      syllables: ['PHANT', 'ELE'],
      answer: 'ELEPHANT',
    ),
    _WordBuilderQuestion(
      definition: 'The season between summer and winter.',
      syllables: ['TUMN', 'AU'],
      answer: 'AUTUMN',
    ),
    _WordBuilderQuestion(
      definition: 'A person who flies an airplane.',
      syllables: ['LOT', 'PI'],
      answer: 'PILOT',
    ),
    _WordBuilderQuestion(
      definition: 'A place where books are kept.',
      syllables: ['RY', 'LIB', 'RA'],
      answer: 'LIBRARY',
    ),
    _WordBuilderQuestion(
      definition: 'An instrument used to measure time.',
      syllables: ['DAR', 'CAL', 'EN'],
      answer: 'CALENDAR',
    ),
    _WordBuilderQuestion(
      definition: 'A very high mountain.',
      syllables: ['EST', 'EV', 'ER'],
      answer: 'EVEREST',
    ),
    _WordBuilderQuestion(
      definition: 'A small animal that lives in a shell.',
      syllables: ['TLE', 'TUR'],
      answer: 'TURTLE',
    ),
    _WordBuilderQuestion(
      definition: 'A frozen dessert made from milk.',
      syllables: ['CREAM', 'ICE'],
      answer: 'ICECREAM',
    ),
    _WordBuilderQuestion(
      definition: 'A person who cooks food in a restaurant.',
      syllables: ['CHEN', 'KIT'],
      answer: 'KITCHEN',
    ),
    _WordBuilderQuestion(
      definition: 'A vehicle that travels through space.',
      syllables: ['SHIP', 'ROCK', 'ET'],
      answer: 'ROCKETSHIP',
    ),
    _WordBuilderQuestion(
      definition: 'A bright celestial body seen at night.',
      syllables: ['NET', 'PLA'],
      answer: 'PLANET',
    ),
    _WordBuilderQuestion(
      definition: 'A structure built over a river.',
      syllables: ['DGE', 'BRI'],
      answer: 'BRIDGE',
    ),
    _WordBuilderQuestion(
      definition: 'A person who treats sick people.',
      syllables: ['TOR', 'DOC'],
      answer: 'DOCTOR',
    ),
  ];

  _WordBuilderQuestion get _currentQuestion =>
      _questions[_currentQuestionIndex];

  void _selectSyllable(String syllable) {
    setState(() {
      _selectedSyllables.add(syllable);
    });
  }

  void _removeSyllable(int index) {
    setState(() {
      _selectedSyllables.removeAt(index);
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedSyllables.clear();
    });
  }

  void _checkAnswer() {
    final answer = _selectedSyllables.join();
    if (answer == _currentQuestion.answer) {
      setState(() {
        _score += 50;
      });
      // Record activity for streak
      ref.read(streakProvider.notifier).recordActivity();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.correct),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
      _nextQuestion();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.incorrect),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedSyllables.clear();
      });
    } else {
      _showGameComplete();
    }
  }

  void _showGameComplete() {
    // Save high score
    final highScores = ref.read(arcadeHighScoresProvider);
    final previousHighScore = highScores.getScore(ArcadeGameType.wordBuilder);
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.wordBuilder, _score);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: _score,
          highScore: previousHighScore,
          accentColor: Colors.indigo,
          extraStats: [
            GameOverStat(label: 'Words Built', value: '${_questions.length}'),
            GameOverStat(label: 'Total Score', value: '$_score'),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            setState(() {
              _questions.shuffle();
              for (var q in _questions) {
                q.syllables.shuffle();
              }
              _currentQuestionIndex = 0;
              _score = 0;
              _selectedSyllables.clear();
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
              _buildHeader(context, theme, l10n),

              // Progress and score
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
                      value:
                          '${_currentQuestionIndex + 1}/${_questions.length}',
                      icon: Icons.help_outline_rounded,
                      color: Colors.indigo,
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

              // Definition card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 40,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _currentQuestion.definition,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Selected syllables (answer area)
              Container(
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedSyllables.isEmpty)
                      Text(
                        'Tap syllables to build the word',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      )
                    else
                      ..._selectedSyllables.asMap().entries.map(
                        (entry) => GestureDetector(
                          onTap: () => _removeSyllable(entry.key),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              entry.value,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Available syllables
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _currentQuestion.syllables.map((syllable) {
                    final isSelected = _selectedSyllables.contains(syllable);
                    return GestureDetector(
                      onTap: isSelected
                          ? null
                          : () => _selectSyllable(syllable),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isSelected ? 0.3 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade400,
                                Colors.indigo.shade600,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.indigo.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            syllable,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const Spacer(),

              // Action buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearSelection,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _selectedSyllables.isNotEmpty
                            ? _checkAnswer
                            : null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Check'),
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

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            l10n.gameWordBuilder,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WordBuilderQuestion {
  final String definition;
  final List<String> syllables;
  final String answer;

  const _WordBuilderQuestion({
    required this.definition,
    required this.syllables,
    required this.answer,
  });
}
