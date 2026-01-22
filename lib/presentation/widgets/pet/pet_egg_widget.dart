import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/constants/app_constants.dart';

/// Widget that displays an egg that the user can tap to select their pet
class PetEggWidget extends StatefulWidget {
  final VoidCallback onTap;

  const PetEggWidget({super.key, required this.onTap});

  @override
  State<PetEggWidget> createState() => _PetEggWidgetState();
}

class _PetEggWidgetState extends State<PetEggWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.petEggAnimationDuration,
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: -0.03,
      end: 0.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.amber : Colors.orange).withValues(
                        alpha: _glowAnimation.value,
                      ),
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Egg shape
                    CustomPaint(
                      size: const Size(85, 115),
                      painter: _EggPainter(
                        baseColor: isDark
                            ? const Color(0xFFFFF8E1)
                            : const Color(0xFFFFFDE7),
                        spotColor: isDark
                            ? const Color(0xFFFFE082)
                            : const Color(0xFFFFECB3),
                      ),
                    ),
                    // Question mark or sparkle
                    Positioned(
                      top: 35,
                      child: Text(
                        '?',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ),
                    // Tap hint - elegant floating badge (static)
                    Positioned(
                      bottom: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple.shade400,
                              Colors.purple.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.4),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.touch_app_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.petTapToHatch,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Custom painter for drawing an egg shape
class _EggPainter extends CustomPainter {
  final Color baseColor;
  final Color spotColor;

  _EggPainter({required this.baseColor, required this.spotColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;

    // Draw egg shape using bezier curves
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w / 2, 0);
    path.cubicTo(w * 0.85, 0, w, h * 0.25, w, h * 0.45);
    path.cubicTo(w, h * 0.75, w * 0.75, h, w / 2, h);
    path.cubicTo(w * 0.25, h, 0, h * 0.75, 0, h * 0.45);
    path.cubicTo(0, h * 0.25, w * 0.15, 0, w / 2, 0);
    path.close();

    // Draw shadow
    canvas.drawShadow(path, Colors.black, 8, false);

    // Draw egg
    canvas.drawPath(path, paint);

    // Draw spots
    final spotPaint = Paint()
      ..color = spotColor
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.3, h * 0.35), width: 14, height: 18),
      spotPaint,
    );

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.7, h * 0.5), width: 10, height: 14),
      spotPaint,
    );

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.4, h * 0.7), width: 12, height: 16),
      spotPaint,
    );

    // Draw highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.35, h * 0.2), width: 18, height: 10),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
