import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Premium page transitions with smooth, relaxed timing
/// Uses simple transforms without expensive blur or rasterization

/// Slide + Fade transition (iOS-style, premium feel)
CustomTransitionPage<T> slideUpTransition<T>({
  required Widget child,
  required LocalKey key,
  Duration duration = const Duration(milliseconds: 450),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: Duration(
      milliseconds: (duration.inMilliseconds * 0.8).round(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Use a smooth, slow curve for premium feel
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInQuart,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(curve),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
            ),
          ),
          child: child,
        ),
      );
    },
  );
}

/// Horizontal slide transition (for navigation between related pages)
CustomTransitionPage<T> slideHorizontalTransition<T>({
  required Widget child,
  required LocalKey key,
  bool fromRight = true,
  Duration duration = const Duration(milliseconds: 450),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: Duration(
      milliseconds: (duration.inMilliseconds * 0.8).round(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInQuart,
      );

      final beginOffset = fromRight
          ? const Offset(0.2, 0)
          : const Offset(-0.2, 0);

      return SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(curve),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
            ),
          ),
          child: child,
        ),
      );
    },
  );
}

/// Pure fade transition (for splash to home)
CustomTransitionPage<T> fadeTransition<T>({
  required Widget child,
  required LocalKey key,
  Duration duration = const Duration(milliseconds: 600),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: Duration(
      milliseconds: (duration.inMilliseconds * 0.7).round(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutQuart),
        child: child,
      );
    },
  );
}

/// Circular reveal transition - Premium circular expansion effect
class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;

  CircularRevealClipper({required this.fraction});

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.sqrt(
      math.pow(size.width / 2, 2) + math.pow(size.height / 2, 2),
    ) * fraction;

    path.addOval(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
