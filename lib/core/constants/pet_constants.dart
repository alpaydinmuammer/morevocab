/// Pet system configuration constants
class PetConstants {
  PetConstants._();

  // Pet Stage Minimum Levels
  static const int stageEggMinLevel = 0;
  static const int stageBabyMinLevel = 1;
  static const int stageYoungMinLevel = 5;
  static const int stageAdultMinLevel = 15;
  static const int stageLegendaryMinLevel = 30;

  // XP Configuration
  static const int xpMultiplierForNextLevel = 200; // XP needed = level * this value
  static const int xpPerLevelBase = 100;

  // XP Rewards
  static const int xpCorrectSwipe = 10;
  static const int xpDailyLoginBonus = 25;
  static const int xpWeekStreakBonus = 100;

  // Evolution Level Thresholds (for next evolution display)
  static const List<int> evolutionLevels = [
    stageBabyMinLevel,
    stageYoungMinLevel,
    stageAdultMinLevel,
    stageLegendaryMinLevel,
  ];
}
