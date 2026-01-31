import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/auth_state.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/firebase_auth_datasource.dart';
import '../../core/services/cloud_sync_service.dart';

const _guestModeKey = 'is_guest_mode';

/// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

/// Stream provider for auth state changes
final authStateProvider = StreamProvider<AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateStream;
});

/// Provider for current user
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenData((state) {
    if (state is AuthAuthenticated) {
      return state.user;
    }
    return null;
  }).valueOrNull;
});

/// Provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenData((state) => state is AuthAuthenticated).valueOrNull ?? false;
});

/// Provider for checking if Apple Sign-In is available
final isAppleSignInAvailableProvider = Provider<bool>((ref) {
  return FirebaseAuthDatasource.isAppleSignInAvailable;
});

/// Auth notifier for handling sign-in/sign-out actions
class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;
  final CloudSyncService _cloudSync = CloudSyncService();

  AuthNotifier(this._repository) : super(const AsyncValue.data(null));

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await _repository.signInWithGoogle();

    return result.when(
      success: (user) async {
        // Link user to RevenueCat for subscription tracking
        await _linkUserToRevenueCat(user.uid);
        // Sync data after successful login
        await _performCloudSync();
        state = const AsyncValue.data(null);
        return true;
      },
      failure: (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return false;
      },
    );
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    state = const AsyncValue.loading();
    final result = await _repository.signInWithApple();

    return result.when(
      success: (user) async {
        // Link user to RevenueCat for subscription tracking
        await _linkUserToRevenueCat(user.uid);
        // Sync data after successful login
        await _performCloudSync();
        state = const AsyncValue.data(null);
        return true;
      },
      failure: (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return false;
      },
    );
  }

  /// Sign out
  Future<bool> signOut() async {
    state = const AsyncValue.loading();

    // Upload final state to cloud before signing out
    try {
      await _cloudSync.syncToCloud();
    } catch (e) {
      debugPrint('Failed to sync before sign out: $e');
    }

    // RevenueCat disabled for initial release
    // try {
    //   await _subscriptionService.logOut();
    // } catch (e) {
    //   debugPrint('Failed to log out from RevenueCat: $e');
    // }

    final result = await _repository.signOut();

    return result.when(
      success: (_) {
        state = const AsyncValue.data(null);
        return true;
      },
      failure: (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return false;
      },
    );
  }

  /// Link user to RevenueCat for subscription tracking
  /// RevenueCat disabled for initial release
  Future<void> _linkUserToRevenueCat(String userId) async {
    // RevenueCat disabled - no-op
  }

  /// Perform cloud sync (smart merge)
  Future<void> _performCloudSync() async {
    try {
      final updated = await _cloudSync.smartSync();
      if (updated) {
        debugPrint('Cloud sync: Local data was updated from cloud');
      }
    } catch (e) {
      debugPrint('Cloud sync failed: $e');
      // Don't block login on sync failure
    }
  }

  /// Manual sync trigger (can be called from settings)
  Future<bool> manualSync() async {
    try {
      await _cloudSync.smartSync();
      return true;
    } catch (e) {
      debugPrint('Manual sync failed: $e');
      return false;
    }
  }

  /// Clear error state
  void clearError() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for AuthNotifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// Guest mode state notifier
class GuestModeNotifier extends StateNotifier<bool> {
  GuestModeNotifier() : super(false) {
    _loadGuestMode();
  }

  Future<void> _loadGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_guestModeKey) ?? false;
  }

  Future<void> setGuestMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_guestModeKey, value);
    state = value;
  }

  Future<void> clearGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_guestModeKey);
    state = false;
  }
}

/// Provider for guest mode
final guestModeProvider = StateNotifierProvider<GuestModeNotifier, bool>((ref) {
  return GuestModeNotifier();
});

/// Provider for checking if user can access app (authenticated OR guest)
final canAccessAppProvider = Provider<bool>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final isGuest = ref.watch(guestModeProvider);
  return isAuthenticated || isGuest;
});
