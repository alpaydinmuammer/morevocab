import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import 'widgets/game_over_screen.dart';
import 'widgets/arcade_stat_card.dart';
import 'word_builder_questions.dart';

/// Word Builder Game - Build words from syllables based on definitions
class WordBuilderGame extends ConsumerStatefulWidget {
  const WordBuilderGame({super.key});

  @override
  ConsumerState<WordBuilderGame> createState() => _WordBuilderGameState();
}

class _WordBuilderGameState extends ConsumerState<WordBuilderGame> {
  int _currentQuestionIndex = 0;
  final List<int> _selectedSyllables = [];
  late final List<WordBuilderQuestion> _questions;

  @override
  void initState() {
    super.initState();
    // Create a local mutable copy of the questions for this session
    // This is necessary because the static list contains const lists which cannot be shuffled
    _questions = WordBuilderQuestions.questions.map((q) {
      return WordBuilderQuestion(
        definition: q.definition,
        syllables: List<String>.from(q.syllables)..shuffle(),
        answer: q.answer,
      );
    }).toList();

    // Load saved level
    final savedLevel = ref
        .read(arcadeHighScoresProvider)
        .getLevel(ArcadeGameType.wordBuilder);

    // Ensure we don't go out of bounds if new questions are added or removed
    if (savedLevel < _questions.length) {
      _currentQuestionIndex = savedLevel;
    } else {
      _currentQuestionIndex = 0;
    }
  }

  WordBuilderQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  void _selectSyllable(int index) {
    setState(() {
      _selectedSyllables.add(index);
    });
  }

  void _removeSyllable(int selectionIndex) {
    setState(() {
      _selectedSyllables.removeAt(selectionIndex);
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedSyllables.clear();
    });
  }

  void _checkAnswer() {
    final answer = _selectedSyllables
        .map((i) => _currentQuestion.syllables[i])
        .join();
    if (answer == _currentQuestion.answer) {
      // Save progress immediately
      final nextLevel = _currentQuestionIndex + 1;
      ref
          .read(arcadeHighScoresProvider.notifier)
          .updateLevel(ArcadeGameType.wordBuilder, nextLevel);

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: 0,
          showScore: false,
          highScore: 0,
          accentColor: Colors.indigo,
          extraStats: [
            GameOverStat(label: 'Words Built', value: '${_questions.length}'),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            // Reset logic for play again
            // For now, reset to 0 to replay
            setState(() {
              // No shuffling for levels
              _currentQuestionIndex = 0;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ArcadeStatCard(
                      label: 'Level',
                      value: '${_currentQuestionIndex + 1}',
                      icon: Icons.flag_rounded,
                      color: Colors.indigo,
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
                              _currentQuestion.syllables[entry.value],
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
                  children: _currentQuestion.syllables.asMap().entries.map((
                    entry,
                  ) {
                    final index = entry.key;
                    final syllable = entry.value;
                    final isSelected = _selectedSyllables.contains(index);
                    return GestureDetector(
                      onTap: isSelected ? null : () => _selectSyllable(index),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isSelected ? 0.3 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
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
                            style: theme.textTheme.titleMedium?.copyWith(
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
