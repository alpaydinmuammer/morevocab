import 'package:flutter/material.dart';

/// Centralized color constants used across the app
/// These are semantic colors not covered by ThemeData
class ColorPalette {
  ColorPalette._();

  // ===========================================
  // PAPER & INK THEME (Vintage/Notebook style)
  // ===========================================
  static const paperColor = Color(0xFFFDFCF0);
  static const inkColor = Color(0xFF2C3E50);
  static const highlighterColor = Color(0xFFFDFD96);
  static const watercolorBlue = Color(0xFFAEC6CF);

  // ===========================================
  // ACCENT COLORS
  // ===========================================
  static const tealAccent = Color(0xFF4ECDC4);
  static const successGreen = Color(0xFF4CAF50);
  static const darkGreen = Color(0xFF1B3B2F);
  static const darkTeal = Color(0xFF00838F);

  // ===========================================
  // AUTH PAGE GRADIENT
  // ===========================================
  static const authGradientStart = Color(0xFF0A1628);
  static const authGradientMid = Color(0xFF0D2137);
  static const authGradientEnd = Color(0xFF0D2137);
  static const authDarkBg = Color(0xFF1E293B);

  // ===========================================
  // LEADERBOARD MEDALS
  // ===========================================
  static const goldPrimary = Color(0xFFFFD700);
  static const goldSecondary = Color(0xFFFDB931);
  static const silver = Color(0xFFC0C0C0);
  static const bronzePrimary = Color(0xFFCD7F32);
  static const bronzeSecondary = Color(0xFFA0522D);
  static const leaderboardDarkText = Color(0xFF3E2723);
  static const leaderboardDarkBg = Color(0xFF263238);

  // ===========================================
  // GOOGLE SIGN-IN BUTTON
  // ===========================================
  static const googleBlue = Color(0xFF4285F4);
  static const googleGreen = Color(0xFF34A853);
  static const googleYellow = Color(0xFFFBBC05);
  static const googleRed = Color(0xFFEA4335);

  // ===========================================
  // PET EGG COLORS
  // ===========================================
  static const eggLight = Color(0xFFFFF8E1);
  static const eggMedium = Color(0xFFFFFDE7);
  static const eggDark = Color(0xFFFFE082);
  static const eggAccent = Color(0xFFFFECB3);

  // ===========================================
  // ONBOARDING DECORATIVE
  // ===========================================
  static const onboardingRed = Color(0xFFFF6B6B);
  static const onboardingYellow = Color(0xFFFFE66D);
  static const onboardingBlue = Color(0xFF45B7D1);
  static const onboardingGreen = Color(0xFF96CEB4);

  // ===========================================
  // ERROR LOG PAGE
  // ===========================================
  static const errorLogDark = Color(0xFF2A2520);
  static const errorLogLight = Color(0xFFFFFBF0);

  // ===========================================
  // MODAL/DIALOG BACKGROUNDS
  // ===========================================
  static const modalDarkBg = Color(0xFF1E1E2C);
}
