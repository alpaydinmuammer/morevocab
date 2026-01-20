import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/pet_local_datasource.dart';
import '../../data/repositories/pet_repository_impl.dart';
import '../../domain/models/pet_model.dart';
import '../../domain/repositories/pet_repository.dart';

/// Provider for the pet datasource singleton
final petDatasourceProvider = Provider<PetLocalDatasource>((ref) {
  return PetLocalDatasource.instance;
});

/// Provider for the pet repository
final petRepositoryProvider = Provider<PetRepository>((ref) {
  final datasource = ref.watch(petDatasourceProvider);
  return PetRepositoryImpl(datasource);
});

/// Check if user has a pet (for showing egg vs pet)
final hasPetProvider = FutureProvider<bool>((ref) async {
  final repository = ref.watch(petRepositoryProvider);
  return repository.hasPet();
});

/// Main pet state provider
final petProvider = StateNotifierProvider<PetNotifier, PetState>((ref) {
  final repository = ref.watch(petRepositoryProvider);
  return PetNotifier(repository);
});

/// State class for pet
class PetState {
  final PetModel? pet;
  final bool isLoading;
  final String? error;
  final PetGainResult? lastGainResult;

  const PetState({
    this.pet,
    this.isLoading = false,
    this.error,
    this.lastGainResult,
  });

  PetState copyWith({
    PetModel? pet,
    bool? isLoading,
    String? error,
    PetGainResult? lastGainResult,
    bool clearError = false,
    bool clearLastGainResult = false,
  }) {
    return PetState(
      pet: pet ?? this.pet,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      lastGainResult:
          clearLastGainResult ? null : (lastGainResult ?? this.lastGainResult),
    );
  }

  bool get hasPet => pet != null;
}

/// Notifier for pet state management
class PetNotifier extends StateNotifier<PetState> {
  final PetRepository _repository;

  PetNotifier(this._repository) : super(const PetState(isLoading: true)) {
    _loadPet();
  }

  /// Load pet from storage
  Future<void> _loadPet() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.getPet();
    result.when(
      success: (pet) {
        state = state.copyWith(pet: pet, isLoading: false);
      },
      failure: (error) {
        state = state.copyWith(error: error, isLoading: false);
      },
    );
  }

  /// Create a new pet
  Future<bool> createPet({
    required String name,
    required PetType type,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final pet = PetModel.create(name: name, type: type);
    final result = await _repository.savePet(pet);

    return result.when(
      success: (_) {
        state = state.copyWith(pet: pet, isLoading: false);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error, isLoading: false);
        return false;
      },
    );
  }

  /// Add experience to the pet
  Future<PetGainResult?> addExperience(int amount) async {
    if (state.pet == null) return null;

    final result = await _repository.addExperience(amount);

    return result.when(
      success: (gainResult) {
        state = state.copyWith(
          pet: gainResult.pet,
          lastGainResult: gainResult,
        );
        return gainResult;
      },
      failure: (error) {
        state = state.copyWith(error: error);
        return null;
      },
    );
  }

  /// Clear the last gain result (after showing animation)
  void clearLastGainResult() {
    state = state.copyWith(clearLastGainResult: true);
  }

  /// Update pet name
  Future<bool> updatePetName(String newName) async {
    if (state.pet == null) return false;

    final updatedPet = state.pet!.copyWith(name: newName);
    final result = await _repository.savePet(updatedPet);

    return result.when(
      success: (_) {
        state = state.copyWith(pet: updatedPet);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error);
        return false;
      },
    );
  }

  /// Delete pet (reset)
  Future<bool> deletePet() async {
    final result = await _repository.deletePet();

    return result.when(
      success: (_) {
        state = const PetState();
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error);
        return false;
      },
    );
  }

  /// Refresh pet data from storage
  Future<void> refresh() async {
    await _loadPet();
  }
}
