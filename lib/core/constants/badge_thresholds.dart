/// Achievement badge unlock thresholds
/// Organized by badge tier: Bronze < Silver < Gold
class BadgeThresholds {
  BadgeThresholds._();

  // ===========================================
  // ANAGRAM GAME (Level-based)
  // ===========================================
  static const anagramBronze = 5;
  static const anagramSilver = 15;
  static const anagramGold = 30;

  // ===========================================
  // WORD CHAIN GAME (Score-based)
  // ===========================================
  static const chainBronze = 500;
  static const chainSilver = 1000;
  static const chainGold = 1500;

  // ===========================================
  // ODD ONE OUT GAME (Score-based)
  // ===========================================
  static const oddBronze = 100;
  static const oddSilver = 250;
  static const oddGold = 500;

  // ===========================================
  // EMOJI PUZZLE GAME (Level-based)
  // ===========================================
  static const emojiBronze = 10;
  static const emojiSilver = 20;
  static const emojiGold = 30;

  // ===========================================
  // WORD BUILDER GAME (Score-based)
  // ===========================================
  static const builderBronze = 100;
  static const builderSilver = 250;
  static const builderGold = 500;

  // ===========================================
  // DAILY STREAK (Days)
  // ===========================================
  static const streakBronze = 7; // 1 week
  static const streakSilver = 30; // 1 month
  static const streakGold = 100; // ~3 months

  // ===========================================
  // TOTAL BADGES MILESTONE
  // ===========================================
  static const milestoneBronze = 5;
  static const milestoneSilver = 10;
  static const milestoneGold = 20;
}
