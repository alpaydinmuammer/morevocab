import '../../core/utils/result.dart';
import '../../domain/models/pet_model.dart';
import '../../domain/repositories/pet_repository.dart';
import '../datasources/pet_local_datasource.dart';

/// Implementation of PetRepository using local datasource
class PetRepositoryImpl implements PetRepository {
  final PetLocalDatasource _datasource;

  PetRepositoryImpl(this._datasource);

  @override
  Future<bool> hasPet() async {
    try {
      return await _datasource.hasPet();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Result<PetModel?>> getPet() async {
    try {
      final pet = await _datasource.getPet();
      return Success(pet);
    } catch (e) {
      return Failure('Failed to load pet: $e');
    }
  }

  @override
  Future<Result<void>> savePet(PetModel pet) async {
    try {
      await _datasource.savePet(pet);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save pet: $e');
    }
  }

  @override
  Future<Result<void>> deletePet() async {
    try {
      await _datasource.deletePet();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete pet: $e');
    }
  }

  @override
  Future<Result<PetGainResult>> addExperience(int amount) async {
    try {
      final result = await _datasource.addExperience(amount);
      if (result == null) {
        return const Failure('No pet found');
      }
      return Success(result);
    } catch (e) {
      return Failure('Failed to add experience: $e');
    }
  }
}
