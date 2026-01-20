class AppConstants {
  // App Info
  static const String appName = 'More Vocab';
  static const String appVersion = '1.0.0';

  // Database
  static const String isarDbName = 'more_vocab_db';

  // Swipe Thresholds
  static const double swipeThreshold = 100.0;
  static const int maxCardsPerSession = 20;

  // Animation Durations
  static const Duration cardFlipDuration = Duration(milliseconds: 400);
  static const Duration swipeDuration = Duration(milliseconds: 300);
  static const Duration overlayFadeDuration = Duration(milliseconds: 200);
  static const Duration splashAnimationDuration = Duration(milliseconds: 2200);
  static const Duration sessionCompleteAnimationShort = Duration(milliseconds: 600);
  static const Duration sessionCompleteAnimationMedium = Duration(milliseconds: 800);
  static const Duration fadeInDuration = Duration(milliseconds: 350);

  // Opacity Values
  static const double opacityVeryLight = 0.1;
  static const double opacityLight = 0.3;
  static const double opacityMedium = 0.5;
  static const double opacityMediumHigh = 0.7;
  static const double opacityHigh = 0.8;
  static const double opacityAlmostFull = 0.9;

  // Font Sizes
  static const double fontSizeSmall = 20.0;
  static const double fontSizeMedium = 26.0;
  static const double fontSizeLarge = 28.0;
  static const double fontSizeXLarge = 32.0;
  static const double fontSizeXXLarge = 36.0;

  // Icon Sizes
  static const double iconSizeSmall = 64.0;
  static const double iconSizeMedium = 80.0;
  static const double iconSizeLarge = 100.0;
  static const double iconSizeXLarge = 120.0;

  // Border Radius Values
  static const double borderRadiusXSmall = 12.0;
  static const double borderRadiusSmall = 16.0;
  static const double borderRadiusMedium = 20.0;
  static const double borderRadiusLarge = 24.0;
  static const double borderRadiusXLarge = 28.0;
  static const double borderRadiusXXLarge = 32.0;

  // Blur Radius Values
  static const double blurRadiusXSmall = 4.0;
  static const double blurRadiusSmall = 8.0;
  static const double blurRadiusMedium = 10.0;
  static const double blurRadiusLarge = 12.0;
  static const double blurRadiusXLarge = 16.0;
  static const double blurRadiusXXLarge = 20.0;
  static const double blurRadiusXXXLarge = 30.0;

  // Splash Animation Values
  static const double splashCardSlideDistance = 80.0;
  static const double splashCardRotationStart1 = -0.05;
  static const double splashCardRotationEnd1 = 0.2;
  static const double splashCardRotationStart2 = 0.05;
  static const double splashCardRotationEnd2 = -0.2;
  static const double splashNavigationThreshold = 0.90;

  // Default Values
  static const int defaultReviewIntervalDays = 1;
  static const int maxReviewCount = 5;
}
