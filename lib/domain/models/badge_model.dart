/// Badge types for achievement system
enum BadgeType {
  // Anagram badges (Level-based)
  anagramRookie, // Level 5
  anagramExpert, // Level 15
  anagramChampion, // Level 30
  // Word Chain badges (Score-based)
  chainStarter, // 100 points
  chainMaster, // 300 points
  chainLegend, // 500 points
  // Odd One Out badges (Level-based)
  observer, // Level 10
  detective, // Level 30
  sharpshooter, // Level 50
  // Emoji Puzzle badges (Level-based)
  emojiSolver, // Level 10
  puzzleMaster, // Level 20
  emojiLegend, // Level 30
  // Word Builder badges (Level-based)
  wordWorker, // Level 15
  wordArchitect, // Level 30
  wordKing, // Level 50
  // Streak badges
  fireSpirit, // 7 day streak
  dedicated, // 14 day streak
  legendary, // 30 day streak
  // Special badges
  firstStep, // Unlock first badge
  arcadeFan, // Bronze in all games
  brainBoss, // Gold in all games
}

/// Badge tier for visual styling
enum BadgeTier { bronze, silver, gold, special }

/// Badge model
class Badge {
  final BadgeType type;
  final String icon;
  final BadgeTier tier;
  final int requirement;
  final DateTime? unlockedAt;

  const Badge({
    required this.type,
    required this.icon,
    required this.tier,
    required this.requirement,
    this.unlockedAt,
  });

  bool get isUnlocked => unlockedAt != null;

  Badge copyWith({DateTime? unlockedAt}) {
    return Badge(
      type: type,
      icon: icon,
      tier: tier,
      requirement: requirement,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

/// Badge definitions with their requirements
class BadgeDefinitions {
  static const List<Badge> all = [
    // Anagram (Level-based)
    Badge(
      type: BadgeType.anagramRookie,
      icon: '🔤',
      tier: BadgeTier.bronze,
      requirement: 5,
    ),
    Badge(
      type: BadgeType.anagramExpert,
      icon: '🔠',
      tier: BadgeTier.silver,
      requirement: 15,
    ),
    Badge(
      type: BadgeType.anagramChampion,
      icon: '👑',
      tier: BadgeTier.gold,
      requirement: 30,
    ),

    // Word Chain (Score-based) - harder
    Badge(
      type: BadgeType.chainStarter,
      icon: '⛓️',
      tier: BadgeTier.bronze,
      requirement: 500,
    ),
    Badge(
      type: BadgeType.chainMaster,
      icon: '🔗',
      tier: BadgeTier.silver,
      requirement: 1000,
    ),
    Badge(
      type: BadgeType.chainLegend,
      icon: '⚡',
      tier: BadgeTier.gold,
      requirement: 1500,
    ),

    // Odd One Out (Score-based) - harder
    Badge(
      type: BadgeType.observer,
      icon: '🔍',
      tier: BadgeTier.bronze,
      requirement: 100,
    ),
    Badge(
      type: BadgeType.detective,
      icon: '🕵️',
      tier: BadgeTier.silver,
      requirement: 250,
    ),
    Badge(
      type: BadgeType.sharpshooter,
      icon: '🎯',
      tier: BadgeTier.gold,
      requirement: 500,
    ),

    // Emoji Puzzle (Level-based)
    Badge(
      type: BadgeType.emojiSolver,
      icon: '😊',
      tier: BadgeTier.bronze,
      requirement: 10,
    ),
    Badge(
      type: BadgeType.puzzleMaster,
      icon: '🧩',
      tier: BadgeTier.silver,
      requirement: 20,
    ),
    Badge(
      type: BadgeType.emojiLegend,
      icon: '🏆',
      tier: BadgeTier.gold,
      requirement: 30,
    ),

    // Word Builder (Score-based) - harder
    Badge(
      type: BadgeType.wordWorker,
      icon: '🔨',
      tier: BadgeTier.bronze,
      requirement: 100,
    ),
    Badge(
      type: BadgeType.wordArchitect,
      icon: '🏗️',
      tier: BadgeTier.silver,
      requirement: 250,
    ),
    Badge(
      type: BadgeType.wordKing,
      icon: '🏰',
      tier: BadgeTier.gold,
      requirement: 500,
    ),

    // Streak badges - harder
    Badge(
      type: BadgeType.fireSpirit,
      icon: '🔥',
      tier: BadgeTier.bronze,
      requirement: 7,
    ),
    Badge(
      type: BadgeType.dedicated,
      icon: '🌟',
      tier: BadgeTier.silver,
      requirement: 30,
    ),
    Badge(
      type: BadgeType.legendary,
      icon: '💎',
      tier: BadgeTier.gold,
      requirement: 100,
    ),

    // Special badges - based on total badges unlocked
    Badge(
      type: BadgeType.firstStep,
      icon: '⭐',
      tier: BadgeTier.special,
      requirement: 5,
    ),
    Badge(
      type: BadgeType.arcadeFan,
      icon: '🎮',
      tier: BadgeTier.special,
      requirement: 10,
    ),
    Badge(
      type: BadgeType.brainBoss,
      icon: '🧠',
      tier: BadgeTier.special,
      requirement: 20,
    ),
  ];

  static Badge getByType(BadgeType type) {
    return all.firstWhere((b) => b.type == type);
  }
}
