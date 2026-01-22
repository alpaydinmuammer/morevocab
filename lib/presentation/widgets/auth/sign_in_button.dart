import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

/// Sign-in button types
enum SignInButtonType { google, apple }

/// Premium sign-in button widget for Google and Apple authentication
class SignInButton extends StatefulWidget {
  final SignInButtonType type;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool disabled;

  const SignInButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.isLoading && !widget.disabled) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isGoogle = widget.type == SignInButtonType.google;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: (widget.isLoading || widget.disabled) ? null : widget.onPressed,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.disabled ? 0.4 : 1.0,
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            // Glass style for both buttons
            color: Colors.white.withValues(alpha: _isPressed ? 0.15 : 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: _isPressed ? 0.3 : 0.2),
              width: 1.5,
            ),
          ),
          child: widget.isLoading
              ? Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isGoogle ? const Color(0xFF4285F4) : Colors.white,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    if (isGoogle) ...[
                      _buildGoogleIcon(),
                    ] else ...[
                      const Icon(
                        Icons.apple,
                        size: 26,
                        color: Colors.white,
                      ),
                    ],
                    const SizedBox(width: 12),
                    // Text
                    Text(
                      isGoogle
                          ? l10n.continueWithGoogle
                          : l10n.continueWithApple,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

/// Custom painter for official Google "G" logo using proper paths
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24; // Scale factor (based on 24x24)

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Blue section (right side + bar)
    paint.color = const Color(0xFF4285F4);
    final bluePath = Path()
      ..moveTo(23.52 * s, 12.27 * s)
      ..cubicTo(23.52 * s, 11.48 * s, 23.45 * s, 10.73 * s, 23.32 * s, 10 * s)
      ..lineTo(12 * s, 10 * s)
      ..lineTo(12 * s, 14.26 * s)
      ..lineTo(18.47 * s, 14.26 * s)
      ..cubicTo(18.2 * s, 15.63 * s, 17.4 * s, 16.79 * s, 16.21 * s, 17.56 * s)
      ..lineTo(16.21 * s, 20.34 * s)
      ..lineTo(20.03 * s, 20.34 * s)
      ..cubicTo(22.24 * s, 18.31 * s, 23.52 * s, 15.31 * s, 23.52 * s, 12.27 * s)
      ..close();
    canvas.drawPath(bluePath, paint);

    // Green section (bottom right)
    paint.color = const Color(0xFF34A853);
    final greenPath = Path()
      ..moveTo(12 * s, 24 * s)
      ..cubicTo(15.24 * s, 24 * s, 17.95 * s, 22.92 * s, 20.03 * s, 20.96 * s)
      ..lineTo(16.21 * s, 18.18 * s)
      ..cubicTo(15.15 * s, 18.9 * s, 13.73 * s, 19.36 * s, 12 * s, 19.36 * s)
      ..cubicTo(8.87 * s, 19.36 * s, 6.23 * s, 17.31 * s, 5.27 * s, 14.5 * s)
      ..lineTo(1.29 * s, 14.5 * s)
      ..lineTo(1.29 * s, 17.37 * s)
      ..cubicTo(3.36 * s, 21.49 * s, 7.36 * s, 24 * s, 12 * s, 24 * s)
      ..close();
    canvas.drawPath(greenPath, paint);

    // Yellow section (bottom left)
    paint.color = const Color(0xFFFBBC05);
    final yellowPath = Path()
      ..moveTo(5.27 * s, 14.5 * s)
      ..cubicTo(4.77 * s, 13.12 * s, 4.77 * s, 11.62 * s, 5.27 * s, 10.24 * s)
      ..lineTo(5.27 * s, 7.37 * s)
      ..lineTo(1.29 * s, 7.37 * s)
      ..cubicTo(-0.43 * s, 10.92 * s, -0.43 * s, 13.82 * s, 1.29 * s, 17.37 * s)
      ..lineTo(5.27 * s, 14.5 * s)
      ..close();
    canvas.drawPath(yellowPath, paint);

    // Red section (top)
    paint.color = const Color(0xFFEA4335);
    final redPath = Path()
      ..moveTo(12 * s, 4.64 * s)
      ..cubicTo(13.93 * s, 4.64 * s, 15.68 * s, 5.31 * s, 17.06 * s, 6.57 * s)
      ..lineTo(20.11 * s, 3.52 * s)
      ..cubicTo(17.95 * s, 1.47 * s, 15.24 * s, 0.24 * s, 12 * s, 0.24 * s)
      ..cubicTo(7.36 * s, 0.24 * s, 3.36 * s, 2.75 * s, 1.29 * s, 6.87 * s)
      ..lineTo(5.27 * s, 9.74 * s)
      ..cubicTo(6.23 * s, 6.93 * s, 8.87 * s, 4.88 * s, 12 * s, 4.64 * s)
      ..close();
    canvas.drawPath(redPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
