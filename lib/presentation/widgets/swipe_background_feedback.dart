import 'package:flutter/material.dart';

class SwipeBackgroundFeedback extends StatelessWidget {
  final double swipeOffset; // Range roughly -1.0 to 1.0

  const SwipeBackgroundFeedback({super.key, required this.swipeOffset});

  @override
  Widget build(BuildContext context) {
    // Subscribe to theme changes
    final brightness = Theme.of(context).brightness;

    if (swipeOffset == 0) {
      return const SizedBox.shrink();
    }

    final isRight = swipeOffset > 0;
    final progress = (swipeOffset.abs() * 1.5).clamp(0.0, 1.0);

    // Theme-aware colors
    final Color color;
    if (isRight) {
      color = brightness == Brightness.dark
          ? Colors.green.shade400
          : Colors.green.shade600;
    } else {
      color = brightness == Brightness.dark
          ? Colors.red.shade400
          : Colors.red.shade600;
    }

    final icon = isRight
        ? Icons.arrow_forward_rounded
        : Icons.arrow_back_rounded;

    const baseOpacity = 0.35;
    const midOpacity = 0.15;
    const iconOpacity = 0.22;

    return IgnorePointer(
      child: Stack(
        children: [
          // 1. Radial Gradient Light Beam
          // Kenardan dairesel yayılan yumuşak ışık
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: isRight
                      ? const Alignment(1.2, 0.0)
                      : const Alignment(-1.2, 0.0), // Ekran dışından merkez
                  radius: 1.5, // Geniş yarıçap
                  colors: [
                    // ignore: deprecated_member_use
                    color.withOpacity(baseOpacity * progress),
                    // ignore: deprecated_member_use
                    color.withOpacity(midOpacity * progress),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6, 1.0], // Yumuşak geçiş
                ),
              ),
            ),
          ),

          // 3. Large aesthetic icon
          Positioned.fill(
            child: Align(
              alignment: Alignment(isRight ? 0.4 : -0.4, 0.0),
              child: Opacity(
                opacity: iconOpacity * progress,
                child: Icon(icon, size: 280, color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
