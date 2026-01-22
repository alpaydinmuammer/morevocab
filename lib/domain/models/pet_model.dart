import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/pet_constants.dart';

/// Pet types available for selection
enum PetType { dragon, eagle, wolf, fox }

/// Evolution stages of a pet
enum PetStage { egg, baby, young, adult, legendary }

/// Extension methods for PetType
extension PetTypeExtension on PetType {
  /// Get localized display name (requires BuildContext)
  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case PetType.dragon:
        return l10n.petDragon;
      case PetType.eagle:
        return l10n.petEagle;
      case PetType.wolf:
        return l10n.petWolf;
      case PetType.fox:
        return l10n.petFox;
    }
  }

  /// Fallback display name (Turkish, used for debugging/logging only)
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

  /// Get localized description (requires BuildContext)
  String getLocalizedDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case PetType.dragon:
        return l10n.petDragonDesc;
      case PetType.eagle:
        return l10n.petEagleDesc;
      case PetType.wolf:
        return l10n.petWolfDesc;
      case PetType.fox:
        return l10n.petFoxDesc;
    }
  }

  /// Fallback description (Turkish, used for debugging/logging only)
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
  /// Get localized display name (requires BuildContext)
  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case PetStage.egg:
        return l10n.petTapToHatch; // "Yumurta" is not in ARB, use tap to hatch context
      case PetStage.baby:
        return l10n.petStageBaby;
      case PetStage.young:
        return l10n.petStageYoung;
      case PetStage.adult:
        return l10n.petStageAdult;
      case PetStage.legendary:
        return l10n.petStageLegendary;
    }
  }

  /// Fallback display name (Turkish, used for debugging/logging only)
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
        return PetConstants.stageEggMinLevel;
      case PetStage.baby:
        return PetConstants.stageBabyMinLevel;
      case PetStage.young:
        return PetConstants.stageYoungMinLevel;
      case PetStage.adult:
        return PetConstants.stageAdultMinLevel;
      case PetStage.legendary:
        return PetConstants.stageLegendaryMinLevel;
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
  int get xpForNextLevel => level * PetConstants.xpMultiplierForNextLevel;

  /// Progress percentage towards next level (0.0 to 1.0)
  double get progressToNextLevel {
    if (xpForNextLevel == 0) return 0.0;
    return (experience / xpForNextLevel).clamp(0.0, 1.0);
  }

  /// Current evolution stage based on level
  PetStage get stage {
    if (level >= PetConstants.stageLegendaryMinLevel) return PetStage.legendary;
    if (level >= PetConstants.stageAdultMinLevel) return PetStage.adult;
    if (level >= PetConstants.stageYoungMinLevel) return PetStage.young;
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
    while (newExperience >= newLevel * PetConstants.xpPerLevelBase) {
      newExperience -= newLevel * PetConstants.xpPerLevelBase;
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
  static int get correctSwipe => PetConstants.xpCorrectSwipe;
  static int get dailyLoginBonus => PetConstants.xpDailyLoginBonus;
  static int get weekStreakBonus => PetConstants.xpWeekStreakBonus;

  /// Calculate XP for a correct answer
  static int forCorrectAnswer({int difficulty = 1}) {
    return correctSwipe;
  }
}
