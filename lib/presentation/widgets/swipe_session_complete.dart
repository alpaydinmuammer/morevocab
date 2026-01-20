import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_constants.dart';
import '../providers/word_providers.dart';

class SwipeSessionComplete extends StatelessWidget {
  final WordStudyState state;
  final VoidCallback onStudyAgain;
  final VoidCallback onBackToHome;

  const SwipeSessionComplete({
    super.key,
    required this.state,
    required this.onStudyAgain,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final totalStudied = state.sessionKnownCount + state.sessionReviewCount;
    final (motivationalMessage, motivationalIcon) =
        _getMotivationalMessage(totalStudied, state.words.length, l10n);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(
                alpha: AppConstants.opacityVeryLight,
              ),
              theme.colorScheme.secondary.withValues(
                alpha: AppConstants.opacityVeryLight,
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Animated Success Icon with glow
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: AppConstants.sessionCompleteAnimationMedium,
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: AppConstants.iconSizeXLarge,
                        height: AppConstants.iconSizeXLarge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withValues(
                                alpha: AppConstants.opacityMediumHigh,
                              ),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: AppConstants.opacityLight,
                              ),
                              blurRadius: AppConstants.blurRadiusXXXLarge,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.celebration_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Congratulations Text with animation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: AppConstants.sessionCompleteAnimationShort,
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        l10n.congratulations,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.sessionCompleted,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: AppConstants.opacityMediumHigh,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Motivational Message Banner
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: AppConstants.sessionCompleteAnimationMedium,
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.withValues(
                            alpha: AppConstants.opacityLight,
                          ),
                          Colors.orange.withValues(
                            alpha: AppConstants.opacityVeryLight,
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.amber.withValues(
                          alpha: AppConstants.opacityLight,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          motivationalIcon,
                          color: Colors.amber.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          motivationalMessage,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Circular Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CircularStat(
                      value: state.sessionKnownCount,
                      total: totalStudied,
                      label: l10n.known,
                      color: Colors.green,
                    ),
                    _CircularStat(
                      value: state.sessionReviewCount,
                      total: totalStudied,
                      label: l10n.review,
                      color: Colors.orange,
                    ),
                  ],
                ),

                const Spacer(),

                // Buttons with gradient
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(
                            alpha: AppConstants.opacityHigh,
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: AppConstants.opacityLight,
                          ),
                          blurRadius: AppConstants.blurRadiusLarge,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: onStudyAgain,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusSmall,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.replay_rounded, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            l10n.studyAgain,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onBackToHome,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusSmall,
                        ),
                      ),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withValues(
                          alpha: AppConstants.opacityMedium,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: AppConstants.opacityMediumHigh,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.backToHome,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: AppConstants.opacityHigh,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  (String, IconData) _getMotivationalMessage(
    int totalStudied,
    int totalWords,
    AppLocalizations l10n,
  ) {
    final percentage = totalWords > 0 ? (totalStudied / totalWords) * 100 : 0;

    if (percentage >= 90) {
      return (l10n.motivationalExcellent, Icons.stars_rounded);
    } else if (percentage >= 70) {
      return (l10n.motivationalGreat, Icons.thumb_up_rounded);
    } else if (percentage >= 50) {
      return (l10n.motivationalGood, Icons.emoji_events_rounded);
    } else {
      return (l10n.motivationalKeepPracticing, Icons.fitness_center_rounded);
    }
  }
}

class _CircularStat extends StatelessWidget {
  final int value;
  final int total;
  final String label;
  final Color color;

  const _CircularStat({
    required this.value,
    required this.total,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = total > 0 ? value / total : 0.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: percent),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, animatedPercent, child) {
        return Column(
          children: [
            SizedBox(
              width: AppConstants.iconSizeLarge,
              height: AppConstants.iconSizeLarge,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  SizedBox(
                    width: AppConstants.iconSizeLarge,
                    height: AppConstants.iconSizeLarge,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 10,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        color.withValues(alpha: AppConstants.opacityVeryLight),
                      ),
                    ),
                  ),
                  // Progress circle
                  SizedBox(
                    width: AppConstants.iconSizeLarge,
                    height: AppConstants.iconSizeLarge,
                    child: CircularProgressIndicator(
                      value: animatedPercent,
                      strokeWidth: 10,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  // Value text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$value',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        '/ $total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: AppConstants.opacityMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        );
      },
    );
  }
}
