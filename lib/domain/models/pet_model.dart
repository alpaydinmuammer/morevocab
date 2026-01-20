/// Pet types available for selection
enum PetType { dragon, eagle, wolf, fox }

/// Evolution stages of a pet
enum PetStage { egg, baby, young, adult, legendary }

/// Extension methods for PetType
extension PetTypeExtension on PetType {
  String get displayName {
    switch (this) {
      case PetType.dragon:
        return 'Ejderha';
      case PetType.eagle:
        return 'Kartal';
      case PetType.wolf:
        return 'Kurt';
      case PetType.fox:
        return 'Tilki';
    }
  }

  String get description {
    switch (this) {
      case PetType.dragon:
        return 'Ateşli ve güçlü';
      case PetType.eagle:
        return 'Özgür ve keskin';
      case PetType.wolf:
        return 'Sadık ve cesur';
      case PetType.fox:
        return 'Zeki ve çevik';
    }
  }

  String get emoji {
    switch (this) {
      case PetType.dragon:
        return '🐉';
      case PetType.eagle:
        return '🦅';
      case PetType.wolf:
        return '🐺';
      case PetType.fox:
        return '🦊';
    }
  }

  /// Get the Lottie animation asset path for this pet type and stage
  String getAnimationPath(PetStage stage) {
    final typeName = name;
    final stageName = stage.name;
    return 'assets/animations/pets/${typeName}_$stageName.json';
  }

  /// Get the static image asset path for this pet type and stage
  String getImagePath(PetStage stage) {
    final typeName = name;
    final stageName = stage.name;
    return 'assets/images/pets/${typeName}_$stageName.webp';
  }
}

/// Extension methods for PetStage
extension PetStageExtension on PetStage {
  String get displayName {
    switch (this) {
      case PetStage.egg:
        return 'Yumurta';
      case PetStage.baby:
        return 'Yavru';
      case PetStage.young:
        return 'Genç';
      case PetStage.adult:
        return 'Yetişkin';
      case PetStage.legendary:
        return 'Efsanevi';
    }
  }

  /// Minimum level required for this stage
  int get minLevel {
    switch (this) {
      case PetStage.egg:
        return 0;
      case PetStage.baby:
        return 1;
      case PetStage.young:
        return 5;
      case PetStage.adult:
        return 15;
      case PetStage.legendary:
        return 30;
    }
  }
}

/// Immutable model representing a user's pet companion
class PetModel {
  final String id;
  final String name;
  final PetType type;
  final int level;
  final int experience;
  final int totalExperience;
  final DateTime createdAt;
  final DateTime? lastInteraction;

  const PetModel({
    required this.id,
    required this.name,
    required this.type,
    this.level = 1,
    this.experience = 0,
    this.totalExperience = 0,
    required this.createdAt,
    this.lastInteraction,
  });

  /// XP required to reach the next level
  int get xpForNextLevel => level * 100;

  /// Progress percentage towards next level (0.0 to 1.0)
  double get progressToNextLevel {
    if (xpForNextLevel == 0) return 0.0;
    return (experience / xpForNextLevel).clamp(0.0, 1.0);
  }

  /// Current evolution stage based on level
  PetStage get stage {
    if (level >= 30) return PetStage.legendary;
    if (level >= 15) return PetStage.adult;
    if (level >= 5) return PetStage.young;
    return PetStage.baby;
  }

  /// Check if pet has been hatched (selected and named)
  bool get isHatched => name.isNotEmpty;

  /// Get the animation path for current stage
  String get animationPath => type.getAnimationPath(stage);

  /// Days since the pet was created
  int get daysSinceCreation {
    return DateTime.now().difference(createdAt).inDays;
  }

  /// Days since last interaction (null if never interacted)
  int? get daysSinceLastInteraction {
    if (lastInteraction == null) return null;
    return DateTime.now().difference(lastInteraction!).inDays;
  }

  /// Create a copy with updated values
  PetModel copyWith({
    String? id,
    String? name,
    PetType? type,
    int? level,
    int? experience,
    int? totalExperience,
    DateTime? createdAt,
    DateTime? lastInteraction,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      totalExperience: totalExperience ?? this.totalExperience,
      createdAt: createdAt ?? this.createdAt,
      lastInteraction: lastInteraction ?? this.lastInteraction,
    );
  }

  /// Add experience points and handle level up
  /// Returns a tuple of (updatedPet, didLevelUp, didEvolve)
  PetGainResult gainXp(int amount) {
    int newExperience = experience + amount;
    int newLevel = level;
    int newTotalExperience = totalExperience + amount;
    bool didLevelUp = false;
    PetStage? previousStage = stage;

    // Handle level ups
    while (newExperience >= newLevel * 100) {
      newExperience -= newLevel * 100;
      newLevel++;
      didLevelUp = true;
    }

    final updatedPet = copyWith(
      level: newLevel,
      experience: newExperience,
      totalExperience: newTotalExperience,
      lastInteraction: DateTime.now(),
    );

    // Check if evolved to a new stage
    final didEvolve = updatedPet.stage != previousStage;

    return PetGainResult(
      pet: updatedPet,
      didLevelUp: didLevelUp,
      didEvolve: didEvolve,
      previousStage: previousStage,
      newStage: updatedPet.stage,
      xpGained: amount,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'level': level,
      'experience': experience,
      'totalExperience': totalExperience,
      'createdAt': createdAt.toIso8601String(),
      'lastInteraction': lastInteraction?.toIso8601String(),
    };
  }

  /// Create from JSON
  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: PetType.values[json['type'] as int],
      level: json['level'] as int? ?? 1,
      experience: json['experience'] as int? ?? 0,
      totalExperience: json['totalExperience'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastInteraction: json['lastInteraction'] != null
          ? DateTime.parse(json['lastInteraction'] as String)
          : null,
    );
  }

  /// Create a new pet with default values
  factory PetModel.create({required String name, required PetType type}) {
    return PetModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: type,
      level: 1,
      experience: 0,
      totalExperience: 0,
      createdAt: DateTime.now(),
      lastInteraction: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PetModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.level == level &&
        other.experience == experience &&
        other.totalExperience == totalExperience;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, type, level, experience, totalExperience);
  }

  @override
  String toString() {
    return 'PetModel(name: $name, type: ${type.displayName}, level: $level, stage: ${stage.displayName})';
  }
}

/// Result of gaining XP, includes level up and evolution info
class PetGainResult {
  final PetModel pet;
  final bool didLevelUp;
  final bool didEvolve;
  final PetStage previousStage;
  final PetStage newStage;
  final int xpGained;

  const PetGainResult({
    required this.pet,
    required this.didLevelUp,
    required this.didEvolve,
    required this.previousStage,
    required this.newStage,
    required this.xpGained,
  });
}

/// XP values for different actions
class PetXpValues {
  static const int correctSwipe = 10;
  static const int hardWordBonus = 5; // Extra XP for difficulty >= 4
  static const int dailyLoginBonus = 25;
  static const int weekStreakBonus = 100;

  /// Calculate XP for a correct answer
  static int forCorrectAnswer({int difficulty = 1}) {
    int xp = correctSwipe;
    if (difficulty >= 4) {
      xp += hardWordBonus;
    }
    return xp;
  }
}
