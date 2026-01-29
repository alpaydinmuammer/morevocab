import '../../core/utils/result.dart';
import '../../domain/models/user_model.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

/// Implementation of AuthRepository using Firebase
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _datasource;

  static AuthRepositoryImpl? _instance;

  AuthRepositoryImpl._({required FirebaseAuthDatasource datasource})
      : _datasource = datasource;

  /// Singleton factory
  factory AuthRepositoryImpl() {
    _instance ??= AuthRepositoryImpl._(
      datasource: FirebaseAuthDatasource(),
    );
    return _instance!;
  }

  @override
  Future<Result<void>> init() async {
    try {
      // Firebase Auth is already initialized via Firebase.initializeApp
      // Just return success - auth state will be provided via stream
      return const Success(null);
    } catch (e) {
      return Failure('Failed to initialize auth: $e');
    }
  }

  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    try {
      final user = await _datasource.signInWithGoogle();
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(_getLocalizedErrorMessage(e.errorType));
    } catch (e) {
      // Unexpected error - include type for debugging
      return Failure('Google sign in failed unexpectedly (${e.runtimeType}): $e');
    }
  }

  @override
  Future<Result<UserModel>> signInWithApple() async {
    try {
      final user = await _datasource.signInWithApple();
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(_getLocalizedErrorMessage(e.errorType));
    } catch (e) {
      // Unexpected error - include type for debugging
      return Failure('Apple sign in failed unexpectedly (${e.runtimeType}): $e');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _datasource.signOut();
      return const Success(null);
    } catch (e) {
      // Include error type for easier debugging
      return Failure('Sign out failed (${e.runtimeType}): $e');
    }
  }

  @override
  Stream<AuthState> get authStateStream => _datasource.authStateStream;

  @override
  UserModel? get currentUser => _datasource.currentUser;

  @override
  bool get isAuthenticated => _datasource.isAuthenticated;

  /// Get error message based on error type
  /// Note: These are fallback messages. UI should use localized messages.
  String _getLocalizedErrorMessage(AuthErrorType type) {
    switch (type) {
      case AuthErrorType.network:
        return 'Network error. Please check your connection.';
      case AuthErrorType.cancelled:
        return 'Sign in was cancelled.';
      case AuthErrorType.invalidCredential:
        return 'Invalid credentials. Please try again.';
      case AuthErrorType.userDisabled:
        return 'This account has been disabled.';
      case AuthErrorType.generic:
        return 'Sign in failed. Please try again.';
    }
  }
}
