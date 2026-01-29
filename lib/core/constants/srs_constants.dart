/// Constants for Spaced Repetition System (SRS) algorithm
class SrsConstants {
  SrsConstants._();

  /// Review interval in days for each SRS level
  /// Level 0: Immediate review (wrong answer or new)
  /// Level 1: 1 day
  /// Level 2: 3 days
  /// Level 3: 7 days (1 week)
  /// Level 4: 14 days (2 weeks)
  /// Level 5: 30 days (1 month)
  /// Level 6: 60 days (mastered - lowest priority)
  static const List<int> reviewIntervalDays = [0, 1, 3, 7, 14, 30, 60];

  /// Maximum SRS level (mastered state)
  static const int maxLevel = 6;

  /// Minimum consecutive correct answers to consider mastered
  static const int masteryThreshold = 3;
}
