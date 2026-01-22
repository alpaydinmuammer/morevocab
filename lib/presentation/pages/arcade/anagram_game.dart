import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';

/// Level data for Anagram game
class AnagramLevel {
  final int level;
  final List<String> letters;
  final Set<String> validWords;

  const AnagramLevel({
    required this.level,
    required this.letters,
    required this.validWords,
  });
}

/// Anagram Game - Find words from scrambled letters
class AnagramGame extends ConsumerStatefulWidget {
  const AnagramGame({super.key});

  @override
  ConsumerState<AnagramGame> createState() => _AnagramGameState();
}

class _AnagramGameState extends ConsumerState<AnagramGame> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _foundWords = [];
  int _score = 0;
  int _currentLevelIndex = 0;
  List<String> _letters = [];

  // All game levels
  static const List<AnagramLevel> _levels = [
    // Level 1: EARTH (5 letters, 23 words)
    AnagramLevel(
      level: 1,
      letters: ['T', 'E', 'A', 'R', 'H'],
      validWords: {
        'HEART',
        'EARTH',
        'RATE',
        'TEAR',
        'HEAR',
        'HEAT',
        'HARE',
        'HATE',
        'ATE',
        'EAT',
        'TEA',
        'ARE',
        'EAR',
        'ERA',
        'HAT',
        'THE',
        'HER',
        'ART',
        'TAR',
        'RAT',
        'AT',
        'HE',
        'HA',
      },
    ),
    // Level 2: STONE (5 letters, 25 words)
    AnagramLevel(
      level: 2,
      letters: ['S', 'T', 'O', 'N', 'E'],
      validWords: {
        'STONE',
        'TONES',
        'ONSET',
        'NOTES',
        'NEST',
        'TONE',
        'NOTE',
        'NOSE',
        'ONES',
        'TENS',
        'SENT',
        'NETS',
        'EONS',
        'SET',
        'NET',
        'TEN',
        'TON',
        'SON',
        'NOT',
        'ONE',
        'TOE',
        'SO',
        'NO',
        'ON',
        'TO',
      },
    ),
    // Level 3: DREAM (5 letters, 22 words)
    AnagramLevel(
      level: 3,
      letters: ['D', 'R', 'E', 'A', 'M'],
      validWords: {
        'DREAM',
        'ARMED',
        'DARE',
        'DEAR',
        'READ',
        'MADE',
        'MARE',
        'DAME',
        'DRAM',
        'REAM',
        'ARM',
        'ARE',
        'EAR',
        'ERA',
        'MAD',
        'DAM',
        'RED',
        'DIM',
        'AID',
        'AD',
        'AM',
        'ME',
      },
    ),
    // Level 4: PLANTS (6 letters, 30+ words)
    AnagramLevel(
      level: 4,
      letters: ['P', 'L', 'A', 'N', 'T', 'S'],
      validWords: {
        'PLANTS',
        'SLANT',
        'PANTS',
        'PLANT',
        'PLANS',
        'SPLAT',
        'SALT',
        'SLAP',
        'SNAP',
        'SPAN',
        'TANS',
        'PANS',
        'LAST',
        'PAST',
        'PLAN',
        'PANT',
        'SLAT',
        'ANTS',
        'NAPS',
        'LAPS',
        'TAN',
        'PAN',
        'SAT',
        'PAT',
        'TAP',
        'LAP',
        'NAP',
        'ANT',
        'AS',
        'AT',
      },
    ),
    // Level 5: MASTER (6 letters, 35+ words)
    AnagramLevel(
      level: 5,
      letters: ['M', 'A', 'S', 'T', 'E', 'R'],
      validWords: {
        'MASTER',
        'STREAM',
        'MATERS',
        'SMART',
        'STEAM',
        'TEAMS',
        'MATES',
        'TRAMS',
        'TERMS',
        'MARS',
        'STAR',
        'RATS',
        'EARS',
        'TEAR',
        'ARTS',
        'MAST',
        'SEAT',
        'EATS',
        'MATE',
        'MEAT',
        'TEAM',
        'TAME',
        'REST',
        'RATE',
        'SEAM',
        'SAME',
        'ARMS',
        'MAT',
        'SAT',
        'RAT',
        'EAT',
        'ATE',
        'TEA',
        'SET',
        'ARE',
        'EAR',
        'ERA',
        'ARM',
        'AS',
        'AT',
        'ME',
      },
    ),
  ];

  AnagramLevel get _currentLevel => _levels[_currentLevelIndex];
  bool get _isLastLevel => _currentLevelIndex >= _levels.length - 1;
  bool get _levelComplete =>
      _foundWords.length >= _currentLevel.validWords.length;

  @override
  void initState() {
    super.initState();
    // Load saved level progress after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedLevel = ref
          .read(arcadeHighScoresProvider)
          .getLevel(ArcadeGameType.anagram);
      if (savedLevel > 0 && savedLevel < _levels.length) {
        setState(() {
          _currentLevelIndex = savedLevel;
        });
      }
      _startLevel();
    });
  }

  void _startLevel() {
    setState(() {
      _letters = List.from(_currentLevel.letters);
      _foundWords.clear();
    });
    _shuffleLetters();
  }

  void _shuffleLetters() {
    setState(() {
      _letters = List.from(_letters)..shuffle(Random());
    });
  }

  @override
  void dispose() {
    // Save high score when leaving
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.anagram, _score);
    _controller.dispose();
    super.dispose();
  }

  void _submitWord() {
    final word = _controller.text.trim().toUpperCase();
    if (word.isEmpty) return;

    if (_foundWords.contains(word)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Already found!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    if (_currentLevel.validWords.contains(word)) {
      setState(() {
        _foundWords.add(word);
        _score += word.length * 10;
        _controller.clear();
      });

      // After finding a valid word, record activity for streak
      ref.read(streakProvider.notifier).recordActivity();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.correct} +${word.length * 10}',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );

      // Check if level complete
      if (_levelComplete) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) _showLevelComplete();
        });
      }
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

  void _showLevelComplete() {
    // Save level progress
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateLevel(
          ArcadeGameType.anagram,
          _currentLevelIndex + 1, // Save next level as unlocked
        );
    // Also save high score
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.anagram, _score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Text('🎉 '),
            Text(
              _isLastLevel
                  ? 'All Levels Complete!'
                  : 'Level ${_currentLevel.level} Complete!',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $_score',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Words found: ${_foundWords.length}'),
            if (!_isLastLevel) ...[
              const SizedBox(height: 16),
              Text(
                'Ready for Level ${_currentLevel.level + 1}?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_isLastLevel)
                FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() {
                      _currentLevelIndex++;
                    });
                    _startLevel();
                  },
                  child: const Text('Next Level →'),
                )
              else
                FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() {
                      _currentLevelIndex = 0;
                      _score = 0;
                    });
                    _startLevel();
                  },
                  child: Text(AppLocalizations.of(context)!.playAgain),
                ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.pop();
                },
                child: Text(AppLocalizations.of(context)!.backToHome),
              ),
            ],
          ),
        ],
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
              // Header with level
              _buildHeader(context, theme, l10n),

              // Stats row
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      theme,
                      'Level',
                      '${_currentLevel.level}/${_levels.length}',
                      Colors.indigo,
                    ),
                    _buildStatCard(theme, l10n.score, '$_score', Colors.orange),
                    _buildStatCard(
                      theme,
                      'Found',
                      '${_foundWords.length}/${_currentLevel.validWords.length}',
                      _levelComplete ? Colors.green : Colors.purple,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Letters display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _letters
                      .map((letter) => _buildLetterTile(theme, letter))
                      .toList(),
                ),
              ),

              const SizedBox(height: 12),

              // Shuffle button
              TextButton.icon(
                onPressed: _shuffleLetters,
                icon: const Icon(Icons.shuffle_rounded),
                label: const Text('Shuffle'),
              ),

              const SizedBox(height: 16),

              // Found words
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _foundWords.isEmpty
                      ? Center(
                          child: Text(
                            'Find words using the ${_letters.length} letters above!',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _foundWords
                                .map(
                                  (word) => Chip(
                                    label: Text(word),
                                    backgroundColor: Colors.teal.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ),
              ),

              // Input area
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: 'Type a word...',
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        onSubmitted: (_) => _submitWord(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.teal, Colors.cyan],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        ),
                        onPressed: _submitWord,
                        padding: const EdgeInsets.all(16),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.gameAnagram,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                'Level ${_currentLevel.level}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.teal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLetterTile(ThemeData theme, String letter) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.teal.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    ThemeData theme,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
