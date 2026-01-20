import '../models/pet_model.dart';
import '../../core/utils/result.dart';

/// Repository interface for pet operations
abstract class PetRepository {
  /// Check if user has already selected a pet
  Future<bool> hasPet();

  /// Get the current pet (returns null if no pet exists)
  Future<Result<PetModel?>> getPet();

  /// Save/update the pet
  Future<Result<void>> savePet(PetModel pet);

  /// Delete the pet (for reset functionality)
  Future<Result<void>> deletePet();

  /// Add experience to the pet and handle level ups
  Future<Result<PetGainResult>> addExperience(int amount);
}
