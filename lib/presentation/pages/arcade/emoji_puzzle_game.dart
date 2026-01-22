import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';

/// Emoji Puzzle Game - Guess words from emoji combinations
class EmojiPuzzleGame extends ConsumerStatefulWidget {
  const EmojiPuzzleGame({super.key});

  @override
  ConsumerState<EmojiPuzzleGame> createState() => _EmojiPuzzleGameState();
}

class _EmojiPuzzleGameState extends ConsumerState<EmojiPuzzleGame> {
  final TextEditingController _controller = TextEditingController();
  int _currentIndex = 0;
  int _score = 0;

  final List<_Puzzle> _puzzles = [
    _Puzzle(['🌧️', '🧥', '☔'], 'RAINCOAT'),
    _Puzzle(['🔥', '🚒', '👨‍🚒'], 'FIREFIGHTER'),
    _Puzzle(['🌻', '🌞', '🌺'], 'SUNFLOWER'),
    _Puzzle(['📚', '🏫', '✏️'], 'SCHOOL'),
    _Puzzle(['⚽', '👟', '🏃'], 'FOOTBALL'),
    _Puzzle(['❄️', '⛄', '🧣'], 'SNOWMAN'),
    _Puzzle(['🎂', '🎁', '🎉'], 'BIRTHDAY'),
    _Puzzle(['🐝', '🍯', '🌸'], 'HONEY'),
  ];

  _Puzzle get _current => _puzzles[_currentIndex];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (_controller.text.trim().toUpperCase() == _current.answer) {
      setState(() => _score += 100);
      // Record activity for streak
      ref.read(streakProvider.notifier).recordActivity();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.correct),
          backgroundColor: Colors.green,
        ),
      );
      _next();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.incorrect),
          backgroundColor: Colors.red,
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
    // Save high score
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.emojiPuzzle, _score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.gameOver),
        content: Text('${AppLocalizations.of(context)!.score}: $_score'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _currentIndex = 0;
                    _score = 0;
                    _controller.clear();
                  });
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _stat(
                      theme,
                      'Puzzle',
                      '${_currentIndex + 1}/${_puzzles.length}',
                      Colors.pink,
                    ),
                    _stat(theme, l10n.score, '$_score', Colors.orange),
                  ],
                ),
              ),

              const Spacer(),

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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(e, style: const TextStyle(fontSize: 48)),
                        ),
                      )
                      .toList(),
                ),
              ),

              const Spacer(),

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

  Widget _stat(ThemeData theme, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Puzzle {
  final List<String> emojis;
  final String answer;
  const _Puzzle(this.emojis, this.answer);
}
