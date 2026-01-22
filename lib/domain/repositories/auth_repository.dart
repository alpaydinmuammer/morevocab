import '../models/user_model.dart';
import '../models/auth_state.dart';
import '../../core/utils/result.dart';

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  /// Initialize the auth repository and check current auth state
  Future<Result<void>> init();

  /// Sign in with Google
  Future<Result<UserModel>> signInWithGoogle();

  /// Sign in with Apple
  Future<Result<UserModel>> signInWithApple();

  /// Sign out the current user
  Future<Result<void>> signOut();

  /// Stream of authentication state changes
  Stream<AuthState> get authStateStream;

  /// Current user if authenticated, null otherwise
  UserModel? get currentUser;

  /// Check if user is currently authenticated
  bool get isAuthenticated;
}
