import 'package:flutter/material.dart';

/// Centralized color constants for the app
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color brandPrimary = Color(0xFF001B2C);
  static const Color brandAccent = Colors.indigo;

  // Card Gradient Colors
  static const Color strategyCardGradientStart = Color(0xFF00ACC1);
  static const Color strategyCardGradientEnd = Color(0xFF00838F);

  // Word Card Colors
  static const Color learnedWordDarkBg = Color(0xFF1B3B2F);
  static const Color prepositionTagColor = Color(0xFFFFEB3B);

  // Dark Theme Specific
  static const Color darkCardBackground = Color(0xFF1E1E2C);
  static const Color darkDivider = Colors.white10;

  // Feedback Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Colors.redAccent;
  static const Color warningAmber = Colors.amber;

  // Credits/Role Colors
  static const Color roleDevelopment = Colors.blue;
  static const Color roleDesign = Colors.purple;
  static const Color roleTechnology = Colors.cyan;
  static const Color roleVersion = Colors.teal;

  // Opacity Values
  static const double opacityLight = 0.1;
  static const double opacityMedium = 0.3;
  static const double opacityHigh = 0.7;
}
