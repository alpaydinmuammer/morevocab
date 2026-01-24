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

/// Emoji Puzzle Game - Guess words from emoji combinations
class EmojiPuzzleGame extends ConsumerStatefulWidget {
  const EmojiPuzzleGame({super.key});

  @override
  ConsumerState<EmojiPuzzleGame> createState() => _EmojiPuzzleGameState();
}

class _EmojiPuzzleGameState extends ConsumerState<EmojiPuzzleGame> {
  final TextEditingController _controller = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load saved level
    final savedLevel = ref
        .read(arcadeHighScoresProvider)
        .getLevel(ArcadeGameType.emojiPuzzle);

    if (savedLevel < _puzzles.length) {
      _currentIndex = savedLevel;
    } else {
      _currentIndex = 0;
    }
  }

  // Fixed order for levels
  final List<_Puzzle> _puzzles = [
    _Puzzle(['🌧️', '🧥', '☔'], 'RAINCOAT'),
    _Puzzle(['🔥', '🚒', '👨‍🚒'], 'FIREFIGHTER'),
    _Puzzle(['🌻', '🌞', '🌺'], 'SUNFLOWER'),
    _Puzzle(['📚', '🏫', '✏️'], 'SCHOOL'),
    _Puzzle(['⚽', '👟', '🏃'], 'FOOTBALL'),
    _Puzzle(['❄️', '⛄', '🧣'], 'SNOWMAN'),
    _Puzzle(['🎂', '🎁', '🎉'], 'BIRTHDAY'),
    _Puzzle(['🐝', '🍯', '🌸'], 'HONEY'),
    _Puzzle(['🍎', '🥧'], 'APPLEPIE'),
    _Puzzle(['🍿', '🎬', '👓'], 'MOVIE'),
    _Puzzle(['👸', '🍎', '🏰'], 'SNOWWHITE'),
    _Puzzle(['❄️', '👸', '🏰'], 'FROZEN'),
    _Puzzle(['🐒', '🍌', '🌴'], 'JUNGLE'),
    _Puzzle(['🚀', '👨‍🚀', '🌑'], 'SPACE'),
    _Puzzle(['🏥', '🚑', '🩺'], 'HOSPITAL'),
    _Puzzle(['⌨️', '🖱️', '🖥️'], 'COMPUTER'),
    _Puzzle(['🍳', '🥓', '☕'], 'BREAKFAST'),
    _Puzzle(['🌊', '🌴', '🏖️'], 'BEACH'),
    _Puzzle(['🕷️', '🕸️', '🦸'], 'SPIDERMAN'),
    _Puzzle(['🦁', '👑', '🌅'], 'LIONKING'),
    _Puzzle(['🍔', '🍟', '🥤'], 'FASTFOOD'),
    _Puzzle(['🎸', '🎤', '🥁'], 'BAND'),
    _Puzzle(['🚲', '🚴', '🏁'], 'BICYCLE'),
    _Puzzle(['🥛', '🍪'], 'COOKIES'),
    _Puzzle(['🎨', '🖌️', '🖼️'], 'ARTIST'),
  ];

  _Puzzle get _current => _puzzles[_currentIndex];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (_controller.text.trim().toUpperCase() == _current.answer) {
      // Save progress immediately
      final nextLevel = _currentIndex + 1;
      ref
          .read(arcadeHighScoresProvider.notifier)
          .updateLevel(ArcadeGameType.emojiPuzzle, nextLevel);

      // Update challenge progress
      ref
          .read(challengesProvider.notifier)
          .checkProgress(ArcadeGameType.emojiPuzzle, newLevel: nextLevel);

      // Record activity for streak
      ref.read(streakProvider.notifier).recordActivity();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.correct),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
      _next();
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

  void _next() {
    if (_currentIndex < _puzzles.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.clear();
      });
    } else {
      _showComplete();
    }
  }

  void _showComplete() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: 0,
          highScore: 0,
          showScore: false,
          accentColor: Colors.pink,
          extraStats: [
            GameOverStat(label: 'Puzzles Solved', value: '${_puzzles.length}'),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            setState(() {
              _currentIndex = 0;
              _controller.clear();
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
                      l10n.gameEmojiPuzzle,
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
                      value: '${_currentIndex + 1}/${_puzzles.length}',
                      icon: Icons.flag_rounded,
                      color: Colors.pink,
                    ),
                  ],
                ),
              ),

              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      // Emoji display
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _current.emojis
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 48),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Input
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.characters,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Your guess...',
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _check(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _next,
                            child: const Text('Skip'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: FilledButton(
                            onPressed: _check,
                            child: const Text('Check'),
                          ),
                        ),
                      ],
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
}

class _Puzzle {
  final List<String> emojis;
  final String answer;
  const _Puzzle(this.emojis, this.answer);
}
