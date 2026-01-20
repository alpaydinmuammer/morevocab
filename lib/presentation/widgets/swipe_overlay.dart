import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../l10n/app_localizations.dart';

/// Overlay widget that shows Tinder-style "Stamp" feedback
class SwipeOverlay extends StatelessWidget {
  final CardSwiperDirection direction;
  final double progress;

  const SwipeOverlay({super.key, required this.direction, this.progress = 1.0});

  @override
  Widget build(BuildContext context) {
    final isRight = direction == CardSwiperDirection.right;
    final color = isRight ? Colors.green : Colors.red;
    final text = isRight
        ? AppLocalizations.of(context)!.iKnow.toUpperCase()
        : AppLocalizations.of(context)!.iDontKnow.toUpperCase();

    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.all(
          40.0,
        ), // Match CardSwiper padding + some margin
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: isRight ? 20 : null,
              right: !isRight ? 20 : null,
              child: Opacity(
                opacity: progress,
                child: Transform.rotate(
                  angle: isRight ? -0.2 : 0.2, // Angled stamp
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: color, width: 4),
                      borderRadius: BorderRadius.circular(8),
                      // Optional: subtle glow as requested for premium feel
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: color,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
