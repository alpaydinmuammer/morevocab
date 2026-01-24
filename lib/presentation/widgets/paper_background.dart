import 'package:flutter/material.dart';

class PaperBackground extends StatelessWidget {
  final Widget child;

  const PaperBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCF0), // Off-white cream paper
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Blue ruled lines
            Positioned.fill(child: CustomPaint(painter: _PaperLinesPainter())),
            // Content
            Positioned.fill(child: child),
          ],
        ),
      ),
    );
  }
}

class _PaperLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFAEC6CF)
          .withValues(alpha: 0.5) // Soft blue
      ..strokeWidth = 1.0;

    // Draw horizontal lines
    const lineSpacing = 30.0;
    for (double y = lineSpacing; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
