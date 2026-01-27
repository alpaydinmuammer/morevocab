import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  final bool showTypo;
  final bool showMesh;
  final bool showGrain;

  const PremiumBackground({
    super.key,
    required this.child,
    this.showTypo = true,
    this.showMesh = true,
    this.showGrain = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showMesh) const MeshBackground(),
        if (showTypo) const BackgroundTypo(),
        // GrainOverlay removed for optimization
        // if (showGrain) const GrainOverlay(),
        child,
      ],
    );
  }
}

class MeshBackground extends StatefulWidget {
  const MeshBackground({super.key});

  @override
  State<MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends State<MeshBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use onboarding gradient colors if available, or fallback to surface/primary behavior
    // but user specifically asked for "onboarding background", so we emulate that style
    final startColor =
        theme.extension<AppColors>()?.onboardingGradientStart ??
        theme.colorScheme.surface;

    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Stack(
          children: [
            // Base background
            Container(color: startColor),

            // Blob 1 (Top Left - Primary Color)
            Positioned(
              top: -100 + (math.sin(_bgController.value * 2 * math.pi) * 50),
              left: -50 + (math.cos(_bgController.value * 2 * math.pi) * 30),
              child: MeshBlob(
                color: theme.primaryColor.withValues(alpha: 0.4),
                size: 400,
              ),
            ),

            // Blob 2 (Bottom Right)
            // Fix for Dark Mode: Cyan looks muddy on dark background, so we use Primary (Blue) instead
            // Light Mode: Keep Secondary (Cyan) as user liked it
            Positioned(
              bottom: -50 + (math.cos(_bgController.value * 2 * math.pi) * 50),
              right: -100 + (math.sin(_bgController.value * 2 * math.pi) * 30),
              child: MeshBlob(
                color:
                    (Theme.of(context).brightness == Brightness.dark
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary)
                        .withValues(
                          alpha: Theme.of(context).brightness == Brightness.dark
                              ? 0.2
                              : 0.4,
                        ),
                size: 300,
              ),
            ),

            // Blob 3 (Center - Accent)
            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.4 +
                  (math.sin(_bgController.value * 2 * math.pi) * 30),
              right: -50,
              child: MeshBlob(
                color: Colors.purple.withValues(alpha: 0.25),
                size: 200,
              ),
            ),

            // Glass Overlay to blur the blobs and create "atmosphere"
            // We use a stronger blur here to make sure text is readable on Home Page
            // Glass Overlay removed for performance (GPU killer)
            // The soft RadialGradients in MeshBlob provide enough "atmosphere" without the expensive saveLayer call.
            Container(color: Colors.transparent),
          ],
        );
      },
    );
  }
}

/// Optimized MeshBlob - uses radial gradient instead of expensive BackdropFilter
class MeshBlob extends StatelessWidget {
  final Color color;
  final double size;

  const MeshBlob({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: color.a * 0.5),
            color.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

class BackgroundTypo extends StatelessWidget {
  const BackgroundTypo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final opacity = isDark
        ? 0.025
        : 0.045; // User requested 2.5% dark, 4.5% light
    final color = isDark
        ? theme.colorScheme.onSurface
        : theme.colorScheme.primary;

    final style = theme.textTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w900,
      color: color.withValues(alpha: opacity),
      fontSize: 180,
    );

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: -20,
              child: Transform.rotate(
                angle: -0.15,
                child: Text('G', style: style),
              ),
            ),
            Positioned(
              top: 40,
              right: -40,
              child: Transform.rotate(
                angle: 0.2,
                child: Text('A', style: style),
              ),
            ),
            Positioned(
              top: 300,
              left: -50,
              child: Transform.rotate(
                angle: -0.3,
                child: Text('M', style: style),
              ),
            ),
            Positioned(
              bottom: 150,
              right: -20,
              child: Transform.rotate(
                angle: 0.5,
                child: Text('Z', style: style),
              ),
            ),
            Positioned(
              bottom: -60,
              left: 40,
              child: Transform.rotate(
                angle: 0.1,
                child: Text('E', style: style),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GrainOverlay extends StatelessWidget {
  const GrainOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: GrainPainter(
            opacity: Theme.of(context).brightness == Brightness.dark
                ? 0.03
                : 0.015,
          ),
        ),
      ),
    );
  }
}

/// Optimized GrainPainter - reduced particle count from 2000 to 500
class GrainPainter extends CustomPainter {
  final double opacity;
  GrainPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: opacity);
    final random = math.Random(42);

    // Reduced from 2000 to 500 for performance
    for (var i = 0; i < 500; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.fastOutSlowIn,
      builder: (context, val, child) {
        return Text('${val.toInt()}', style: style);
      },
    );
  }
}

class AnimatedPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedPressable({super.key, required this.child, this.onTap});

  @override
  State<AnimatedPressable> createState() => _AnimatedPressableState();
}

class _AnimatedPressableState extends State<AnimatedPressable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuad,
        reverseCurve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
