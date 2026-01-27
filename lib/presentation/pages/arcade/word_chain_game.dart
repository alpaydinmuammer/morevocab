import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/dictionary_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/arcade_provider.dart';
import '../../providers/challenge_provider.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/premium_background.dart';
import 'widgets/game_over_screen.dart';
import 'widgets/arcade_stat_card.dart';

/// Word Chain Game - Create words starting with the last letter
class WordChainGame extends ConsumerStatefulWidget {
  const WordChainGame({super.key});

  @override
  ConsumerState<WordChainGame> createState() => _WordChainGameState();
}

class _WordChainGameState extends ConsumerState<WordChainGame> {
  static const List<String> _startingWords = [
    'APPLE',
    'BANANA',
    'CHERRY',
    'DREAM',
    'EARTH',
    'FLOWER',
    'GARDEN',
    'HAPPY',
    'ISLAND',
    'JUNGLE',
    'LEMON',
    'MONKEY',
    'NATURE',
    'OCEAN',
    'PIANO',
    'QUEEN',
    'RIVER',
    'STREET',
    'TIGER',
    'VALLEY',
    'WINDOW',
    'YELLOW',
    'ZEBRA',
    'ORANGE',
    'PEACH',
    'STONE',
    'WATER',
    'LIGHT',
    'BREEZE',
    'CLOUD',
  ];

  final List<String> _wordChain = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _score = 0;
  int _timeLeft = 60;
  Timer? _timer;
  bool _isGameOver = false;
  bool _isValidating = false;
  bool _isCheckingConnection = true;

  String get _currentWord => _wordChain.last;
  String get _lastLetter => _currentWord.characters.last.toUpperCase();

  @override
  void initState() {
    super.initState();
    _checkConnectionAndStart();
  }

  Future<void> _checkConnectionAndStart() async {
    _wordChain.add(_startingWords[Random().nextInt(_startingWords.length)]);
    final hasInternet = await DictionaryService.hasInternetConnection();

    if (!mounted) return;

    if (!hasInternet) {
      // Show offline warning dialog
      final continueOffline = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: Colors.orange, size: 28),
              const SizedBox(width: 12),
              const Expanded(child: Text('No Internet')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.offlineWarning,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(AppLocalizations.of(context)!.continueOffline),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(AppLocalizations.of(context)!.backToHome),
                ),
              ],
            ),
          ],
        ),
      );

      if (continueOffline != true) {
        // User chose not to continue
        if (mounted) context.pop();
        return;
      }

      // Enable offline mode
      await DictionaryService.enableOfflineMode();
    } else {
      DictionaryService.enableOnlineMode();
    }

    if (!mounted) return;

    setState(() {
      _isCheckingConnection = false;
    });

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        _showGameOver();
      }
    });
  }

  void _showGameOver() {
    if (_isGameOver) return;
    _isGameOver = true;
    _timer?.cancel();

    // Save high score
    final highScores = ref.read(arcadeHighScoresProvider);
    final previousHighScore = highScores.getScore(ArcadeGameType.wordChain);
    ref
        .read(arcadeHighScoresProvider.notifier)
        .updateScore(ArcadeGameType.wordChain, _score);

    // Update challenge progress
    ref
        .read(challengesProvider.notifier)
        .checkProgress(ArcadeGameType.wordChain, newScore: _score);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          gameId: 'wordChain',
          score: _score,
          highScore: previousHighScore,
          accentColor: Colors.orange,
          extraStats: [
            GameOverStat(label: 'Words', value: '${_wordChain.length}'),
            GameOverStat(
              label: 'Avg Length',
              value:
                  (_wordChain.isEmpty
                          ? 0
                          : _wordChain
                                    .map((e) => e.length)
                                    .reduce((a, b) => a + b) /
                                _wordChain.length)
                      .toStringAsFixed(1),
            ),
          ],
          onPlayAgain: () {
            Navigator.pop(context);
            setState(() {
              _wordChain.clear();
              _wordChain.add(
                _startingWords[Random().nextInt(_startingWords.length)],
              );
              _score = 0;
              _timeLeft = 60;
              _isGameOver = false;
              _controller.clear();
            });
            _startTimer();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitWord() async {
    if (_isValidating) return;

    final word = _controller.text.trim().toUpperCase();
    if (word.isEmpty) return;

    // Check if word starts with the last letter
    if (!word.startsWith(_lastLetter)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Word must start with "$_lastLetter"'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // Check if word was already used
    if (_wordChain.contains(word)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Word already used!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // Minimum 3 letters
    if (word.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Word must be at least 3 letters'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // Validate word using Free Dictionary API
    setState(() => _isValidating = true);

    final isValid = await DictionaryService.isValidWord(word);

    if (!mounted) return;
    setState(() => _isValidating = false);

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$word" is not a valid English word'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // Word is valid!
    setState(() {
      _wordChain.add(word);
      _score += word.length * 10;
      _timeLeft += 5; // Bonus time for correct word
      _controller.clear();
      _focusNode.requestFocus();
    });

    // Record activity for streak
    ref.read(streakProvider.notifier).recordActivity();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AppLocalizations.of(context)!.correct} +${word.length * 10} pts, +5s',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Show loading while checking connection
    if (_isCheckingConnection) {
      return Scaffold(
        body: PremiumBackground(
          showTypo: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Checking connection...',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, theme, l10n),

              // Score and Timer
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArcadeStatCard(
                      label: l10n.score,
                      value: '$_score',
                      icon: Icons.stars_rounded,
                      color: Colors.orange,
                    ),
                    ArcadeStatCard(
                      label: l10n.timeLeft,
                      value: '${_timeLeft}s',
                      icon: Icons.timer_rounded,
                      color: _timeLeft <= 10 ? Colors.red : Colors.green,
                    ),
                  ],
                ),
              ),

              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      // Current word display
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Current Word',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _currentWord,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                  letterSpacing: 4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Next word starts with: $_lastLetter',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Word chain history
                      if (_wordChain.length > 1)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: _wordChain
                                .sublist(0, _wordChain.length - 1)
                                .map((word) {
                                  // Reduce font size if many words
                                  final fontSize = _wordChain.length > 10
                                      ? 11.0
                                      : _wordChain.length > 6
                                      ? 12.0
                                      : 14.0;
                                  final padding = _wordChain.length > 10
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        )
                                      : const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        );

                                  return Container(
                                    padding: padding,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Text(
                                      word,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.w500,
                                            color: theme
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Input area
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        textCapitalization: TextCapitalization.characters,
                        enabled: !_isGameOver,
                        decoration: InputDecoration(
                          hintText: 'Type a word starting with $_lastLetter...',
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (_) => _submitWord(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: _isValidating
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                        onPressed: (_isGameOver || _isValidating)
                            ? null
                            : _submitWord,
                        padding: const EdgeInsets.all(12),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              onPressed: () {
                _timer?.cancel();
                context.pop();
              },
            ),
          ),
          const SizedBox(width: 16),
          Text(
            l10n.gameWordChain,
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
