import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/premium_background.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final int? highScore;
  final String? title;
  final List<GameOverStat>? extraStats;
  final VoidCallback onPlayAgain;
  final VoidCallback? onBackToHome;
  final Color accentColor;
  final bool showScore;

  const GameOverScreen({
    super.key,
    required this.score,
    this.highScore,
    this.title,
    this.extraStats,
    required this.onPlayAgain,
    this.onBackToHome,
    this.accentColor = Colors.orange,
    this.showScore = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isNewHighScore =
        showScore && highScore != null && score >= highScore!;

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Success Icon with Glow
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              accentColor,
                              accentColor.withValues(alpha: 0.7),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.4),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          isNewHighScore
                              ? Icons.emoji_events_rounded
                              : Icons.sports_esports_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Game Over Text
                Text(
                  title ?? l10n.gameOver,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    letterSpacing: 2,
                  ),
                ),

                if (isNewHighScore) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.5),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          color: Colors.amber,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'NEW HIGH SCORE!',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Score Display
                if (showScore)
                  Column(
                    children: [
                      Text(
                        l10n.score.toUpperCase(),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                          letterSpacing: 4,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: score.toDouble()),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeOutExpo,
                        builder: (context, value, child) {
                          return Text(
                            '${value.toInt()}',
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.onSurface,
                              fontSize: 80,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                // Extra Stats Grid
                if (extraStats != null && extraStats!.isNotEmpty)
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: extraStats!.map((stat) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.outline.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              stat.label,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.6,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              stat.value,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                const Spacer(flex: 3),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPlayAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      shadowColor: accentColor.withValues(alpha: 0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.replay_rounded),
                        const SizedBox(width: 8),
                        Text(
                          l10n.playAgain.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed:
                        onBackToHome ??
                        () {
                          Navigator.pop(context); // Pop end screen
                          context.pop(); // Pop game screen
                        },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      l10n.backToHome.toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameOverStat {
  final String label;
  final String value;

  const GameOverStat({required this.label, required this.value});
}
