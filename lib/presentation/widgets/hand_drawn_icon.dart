import 'dart:math';
import 'package:flutter/material.dart';

class HandDrawnIcon extends StatelessWidget {
  final bool isCheck; // true for Check, false for Cross
  final Color color;
  final double size;

  const HandDrawnIcon({
    super.key,
    required this.isCheck,
    required this.color,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HandDrawnPainter(isCheck: isCheck, color: color),
      ),
    );
  }
}

class _HandDrawnPainter extends CustomPainter {
  final bool isCheck;
  final Color color;

  _HandDrawnPainter({required this.isCheck, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Make the color more "inky" (desaturated and darker)
    final HSLColor hsl = HSLColor.fromColor(color);
    final inkColor = hsl.withSaturation(0.35).withLightness(0.3).toColor();

    final paint = Paint()
      ..color = inkColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final random = Random(42);

    if (isCheck) {
      _drawSketchyCheck(canvas, size, paint, random);
    } else {
      _drawSketchyCross(canvas, size, paint, random);
    }
  }

  void _drawSketchyCheck(Canvas canvas, Size size, Paint paint, Random random) {
    // Two overlapping slightly offset strokes for a sketchy ink look
    for (int i = 0; i < 2; i++) {
      final offset = i * 1.5;
      final path = Path();

      // Starting point (left top-ish)
      path.moveTo(
        size.width * 0.15 + (random.nextDouble() * 4 - 2) + offset,
        size.height * 0.5 + (random.nextDouble() * 4 - 2),
      );

      // Bottom point (mid bottom) - using curve for more natural look
      path.quadraticBezierTo(
        size.width * 0.35 + (random.nextDouble() * 6 - 3),
        size.height * 0.9 + (random.nextDouble() * 6 - 3),
        size.width * 0.45 + (random.nextDouble() * 4 - 2) + offset,
        size.height * 0.8 + (random.nextDouble() * 4 - 2),
      );

      // End point (top right)
      path.lineTo(
        size.width * 0.9 + (random.nextDouble() * 4 - 2) + offset,
        size.height * 0.15 + (random.nextDouble() * 4 - 2),
      );

      paint.strokeWidth = i == 0 ? 3.0 : 1.5;
      paint.color = i == 0 ? paint.color : paint.color.withValues(alpha: 0.6);
      canvas.drawPath(path, paint);
    }
  }

  void _drawSketchyCross(Canvas canvas, Size size, Paint paint, Random random) {
    for (int i = 0; i < 2; i++) {
      final offset = i * 1.5;

      // Line 1: \
      _drawRandomlyCurvedLine(
        canvas,
        Offset(size.width * 0.2 + offset, size.height * 0.2),
        Offset(size.width * 0.8 - offset, size.height * 0.8),
        paint,
        random,
      );

      // Line 2: /
      _drawRandomlyCurvedLine(
        canvas,
        Offset(size.width * 0.8 - offset, size.height * 0.2),
        Offset(size.width * 0.2 + offset, size.height * 0.8),
        paint,
        random,
      );

      paint.strokeWidth = 1.5;
      paint.color = paint.color.withValues(alpha: 0.5);
    }
  }

  void _drawRandomlyCurvedLine(
    Canvas canvas,
    Offset p1,
    Offset p2,
    Paint paint,
    Random random,
  ) {
    final path = Path();
    path.moveTo(p1.dx, p1.dy);

    // Add a randomized control point for a slight curve
    final ctrlX = (p1.dx + p2.dx) / 2 + (random.nextDouble() * 8 - 4);
    final ctrlY = (p1.dy + p2.dy) / 2 + (random.nextDouble() * 8 - 4);

    path.quadraticBezierTo(ctrlX, ctrlY, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
