import 'dart:math' as math;
import 'package:flutter/material.dart';

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
        if (showGrain) const GrainOverlay(),
        child,
      ],
    );
  }
}

class MeshBackground extends StatelessWidget {
  const MeshBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned.fill(child: Container(color: theme.colorScheme.surface)),
        // Top Right
        Positioned(
          top: -150,
          right: -100,
          child: MeshBlob(
            color: theme.colorScheme.primary.withValues(
              alpha: isDark ? 0.2 : 0.15,
            ),
            size: 400,
          ),
        ),
        // Center Left
        Positioned(
          top: 250,
          left: -150,
          child: MeshBlob(
            color: theme.colorScheme.secondary.withValues(
              alpha: isDark ? 0.15 : 0.12,
            ),
            size: 350,
          ),
        ),
        // Middle Right
        Positioned(
          top: 400,
          right: -120,
          child: MeshBlob(
            color: Colors.orange.withValues(alpha: isDark ? 0.08 : 0.05),
            size: 300,
          ),
        ),
        // Bottom Left
        Positioned(
          bottom: 100,
          left: -80,
          child: MeshBlob(
            color: Colors.indigo.withValues(alpha: isDark ? 0.1 : 0.08),
            size: 320,
          ),
        ),
        // Bottom Right
        Positioned(
          bottom: -150,
          right: -100,
          child: MeshBlob(
            color: theme.colorScheme.primary.withValues(
              alpha: isDark ? 0.15 : 0.1,
            ),
            size: 450,
          ),
        ),
      ],
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
    final opacity = isDark ? 0.01 : 0.02; // User requested 0.01/0.02
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
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
