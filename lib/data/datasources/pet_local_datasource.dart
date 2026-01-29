import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';
import '../../domain/models/pet_model.dart';

/// Local datasource for pet data using SharedPreferences
class PetLocalDatasource {

  // Singleton instance
  static PetLocalDatasource? _instance;
  static PetLocalDatasource get instance {
    _instance ??= PetLocalDatasource._();
    return _instance!;
  }

  PetLocalDatasource._();

  // For testing purposes
  factory PetLocalDatasource.forTesting() {
    return PetLocalDatasource._();
  }

  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Ensure prefs is initialized
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  /// Check if user has a pet
  Future<bool> hasPet() async {
    final prefs = await _getPrefs();
    return prefs.getBool(StorageKeys.hasPet) ?? false;
  }

  /// Get the stored pet data
  Future<PetModel?> getPet() async {
    final prefs = await _getPrefs();
    final jsonString = prefs.getString(StorageKeys.petData);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return PetModel.fromJson(json);
    } catch (e) {
      // If there's an error parsing, return null
      return null;
    }
  }

  /// Save pet data
  Future<void> savePet(PetModel pet) async {
    final prefs = await _getPrefs();
    final jsonString = jsonEncode(pet.toJson());

    await prefs.setString(StorageKeys.petData, jsonString);
    await prefs.setBool(StorageKeys.hasPet, true);
  }

  /// Delete pet data
  Future<void> deletePet() async {
    final prefs = await _getPrefs();
    await prefs.remove(StorageKeys.petData);
    await prefs.setBool(StorageKeys.hasPet, false);
  }

  /// Update pet with new experience and handle level ups
  Future<PetGainResult?> addExperience(int amount) async {
    final pet = await getPet();
    if (pet == null) return null;

    final result = pet.gainXp(amount);
    await savePet(result.pet);

    return result;
  }
}
