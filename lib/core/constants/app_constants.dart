class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'More Vocab';
  static const String appVersion = '1.0.0';
  static const String logoAssetPath = 'assets/images/logo/morevocablogo1.png';

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
  static const Duration sessionCompleteAnimationShort = Duration(
    milliseconds: 600,
  );
  static const Duration sessionCompleteAnimationMedium = Duration(
    milliseconds: 800,
  );
  static const Duration fadeInDuration = Duration(milliseconds: 350);

  // Opacity Values
  static const double opacityVeryLight = 0.1;
  static const double opacityLow = 0.2;
  static const double opacityLight = 0.3;
  static const double opacitySemiMedium = 0.4;
  static const double opacityMedium = 0.5;
  static const double opacitySemiHigh = 0.6;
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

  // Spread Radius Values
  static const double spreadRadiusMedium = 10.0;

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

  // UI Dimensions
  static const double startButtonHeight = 56.0;
  static const double petSectionHeight = 160.0;
  static const int maxUserNameLength = 9;

  // Greeting Font Sizes (Dynamic based on name length)
  static const double greetingFontSizeLongName = 20.0;
  static const double greetingFontSizeShortName = 24.0;

  // Pet Widget Sizes
  static const double petEmojiSizeLarge = 48.0;
  static const double petEmojiSizeXLarge = 56.0;
  static const double petSelectionEmojiSize = 40.0;

  // Additional Animation Durations
  static const Duration petEggAnimationDuration = Duration(milliseconds: 2000);
  static const Duration petInteractionDuration = Duration(milliseconds: 1500);
  static const Duration creditsModalTransition = Duration(milliseconds: 350);
  static const Duration splashInitialDelay = Duration(milliseconds: 100);
  static const Duration splashDataLoadDelay = Duration(milliseconds: 400);
  static const Duration splashMainAnimationDuration = Duration(
    milliseconds: 3000,
  );

  // ===========================================
  // SPACING SYSTEM (8px Grid)
  // ===========================================
  /// 4.0 - Extra extra small spacing
  static const double spacingXXS = 4.0;

  /// 6.0 - Extra small spacing
  static const double spacingXS = 6.0;

  /// 8.0 - Small spacing
  static const double spacingSM = 8.0;

  /// 10.0 - Small-Medium spacing
  static const double spacingSMD = 10.0;

  /// 12.0 - Medium spacing
  static const double spacingMD = 12.0;

  /// 16.0 - Large spacing
  static const double spacingLG = 16.0;

  /// 20.0 - Extra large spacing
  static const double spacingXL = 20.0;

  /// 24.0 - Extra extra large spacing
  static const double spacingXXL = 24.0;

  /// 32.0 - Extra extra extra large spacing
  static const double spacingXXXL = 32.0;

  /// 40.0 - Huge spacing
  static const double spacingHuge = 40.0;

  /// 48.0 - Massive spacing
  static const double spacingMassive = 48.0;

  // ===========================================
  // TYPOGRAPHY SCALE
  // ===========================================
  /// 8.0 - Tiny text (badges, fine print)
  static const double textTiny = 8.0;

  /// 10.0 - Extra small text
  static const double textXS = 10.0;

  /// 11.0 - Small-Extra small text
  static const double textSXS = 11.0;

  /// 12.0 - Small text
  static const double textSM = 12.0;

  /// 14.0 - Medium text (body)
  static const double textMD = 14.0;

  /// 16.0 - Large text (emphasized body)
  static const double textLG = 16.0;

  /// 18.0 - Extra large text
  static const double textXL = 18.0;

  /// 20.0 - Extra extra large text
  static const double textXXL = 20.0;

  /// 22.0 - Title small
  static const double textTitleSM = 22.0;

  /// 28.0 - Title/Display text
  static const double textDisplay = 28.0;

  /// 32.0 - Hero text
  static const double textHero = 32.0;

  /// 36.0 - Large hero text
  static const double textHeroLG = 36.0;

  /// 40.0 - Emoji/Icon text size
  static const double textEmoji = 40.0;

  /// 42.0 - Large emoji size
  static const double textEmojiLG = 42.0;

  /// 48.0 - Extra large emoji
  static const double textEmojiXL = 48.0;

  /// 180.0 - Background decorative text
  static const double textBackground = 180.0;

  // ===========================================
  // COMMON UI DIMENSIONS
  // ===========================================
  /// Standard button height
  static const double buttonHeightSM = 40.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;

  /// Modal handle dimensions
  static const double modalHandleWidth = 40.0;
  static const double modalHandleHeight = 4.0;

  /// Icon sizes (additional)
  static const double iconSizeTiny = 16.0;
  static const double iconSizeXS = 20.0;
  static const double iconSizeSM = 24.0;
  static const double iconSizeMD = 32.0;

  /// Avatar/Profile sizes
  static const double avatarSizeSM = 40.0;
  static const double avatarSizeMD = 56.0;
  static const double avatarSizeLG = 80.0;

  /// Card dimensions
  static const double cardElevation = 4.0;
  static const double cardElevationHigh = 8.0;
}
