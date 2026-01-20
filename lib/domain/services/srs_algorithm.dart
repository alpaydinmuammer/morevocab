/// Spaced Repetition System (SRS) Algorithm Service
///
/// Implements a hybrid SRS + Leitner box system for optimal vocabulary learning.
/// Based on the principle that words should be reviewed at increasing intervals
/// as they become more familiar.
class SrsAlgorithm {
  /// Review intervals in days for each SRS level
  /// Level 0: New word / Wrong answer - review immediately
  /// Level 1: 1 day
  /// Level 2: 3 days
  /// Level 3: 7 days (1 week)
  /// Level 4: 14 days (2 weeks)
  /// Level 5: 30 days (1 month)
  /// Level 6+: Mastered - 60 days
  static const List<int> intervals = [0, 1, 3, 7, 14, 30, 60];

  /// Maximum SRS level (mastered)
  static const int maxLevel = 6;

  /// Calculate the next review date based on SRS level
  static DateTime calculateNextReview(int srsLevel) {
    final days = srsLevel >= intervals.length
        ? intervals.last
        : intervals[srsLevel];
    return DateTime.now().add(Duration(days: days));
  }

  /// Get the new SRS level based on whether the answer was correct
  /// Correct: level + 1 (up to maxLevel)
  /// Wrong: reset to 0
  static int getNewLevel(int currentLevel, bool isCorrect) {
    if (isCorrect) {
      return (currentLevel + 1).clamp(0, maxLevel);
    } else {
      return 0; // Reset to beginning on wrong answer
    }
  }

  /// Check if a word is due for review
  static bool isDueForReview(DateTime? nextReviewDate) {
    if (nextReviewDate == null) return true; // New word, always due
    return DateTime.now().isAfter(nextReviewDate) ||
        DateTime.now().isAtSameMomentAs(nextReviewDate);
  }

  /// Check if a word is considered mastered
  static bool isMastered(int srsLevel) {
    return srsLevel >= maxLevel;
  }

  /// Get a human-readable description of the SRS level
  static String getLevelDescription(int srsLevel) {
    switch (srsLevel) {
      case 0:
        return 'Yeni';
      case 1:
        return 'Öğreniliyor';
      case 2:
        return 'Tanıdık';
      case 3:
        return 'İyi';
      case 4:
        return 'Çok İyi';
      case 5:
        return 'Mükemmel';
      default:
        return 'Uzmanlaşıldı';
    }
  }

  /// Get days until next review
  static int getDaysUntilReview(DateTime? nextReviewDate) {
    if (nextReviewDate == null) return 0;
    final difference = nextReviewDate.difference(DateTime.now()).inDays;
    return difference < 0 ? 0 : difference;
  }
}
