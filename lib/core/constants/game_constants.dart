/// Constants for arcade games and general game mechanics
class GameConstants {
  GameConstants._();

  // ===========================================
  // WORD CHAIN GAME
  // ===========================================
  static const initialTimeSeconds = 60;
  static const bonusTimeSeconds = 5;
  static const timeScoreMultiplier = 10;
  static const lowTimeThreshold = 10; // When timer turns red

  // ===========================================
  // ODD ONE OUT GAME
  // ===========================================
  static const gridColumns = 2;
  static const gridSpacing = 16.0;
  static const gridAspectRatio = 2.0;
  static const nextQuestionDelayMs = 1500;

  // ===========================================
  // COMMON ANIMATION DURATIONS
  // ===========================================
  static const Duration gameAnimationDuration = Duration(seconds: 1);
  static const Duration nextQuestionDelay = Duration(milliseconds: 1500);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 200);
  static const Duration resultAnimationDuration = Duration(milliseconds: 800);
  static const Duration snackBarDuration = Duration(seconds: 4);

  // ===========================================
  // AUTH PAGE ANIMATIONS
  // ===========================================
  static const Duration authFadeInDuration = Duration(milliseconds: 1200);
  static const Duration authFloatDuration = Duration(milliseconds: 3000);

  // ===========================================
  // DEBOUNCE & TIMEOUTS
  // ===========================================
  static const Duration autoSaveDebounce = Duration(seconds: 2);
  static const Duration apiTimeout = Duration(seconds: 5);
  static const Duration dataLoadTimeout = Duration(seconds: 5);

  // ===========================================
  // ARCADE GAME TYPES (for storage keys)
  // ===========================================
  static const List<String> arcadeGameTypes = [
    'wordChain',
    'anagram',
    'wordBuilder',
    'emojiPuzzle',
    'oddOneOut',
  ];
}
