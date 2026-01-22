import 'user_model.dart';

/// Sealed class representing authentication states
sealed class AuthState {
  const AuthState();
}

/// Initial state before authentication check
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state during authentication operations
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authenticated state with user data
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthAuthenticated && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

/// Unauthenticated state - user needs to sign in
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Error state with message
class AuthError extends AuthState {
  final String message;
  final AuthErrorType type;

  const AuthError({
    required this.message,
    this.type = AuthErrorType.generic,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthError && other.message == message && other.type == type;
  }

  @override
  int get hashCode => Object.hash(message, type);
}

/// Types of authentication errors
enum AuthErrorType {
  network,
  cancelled,
  invalidCredential,
  userDisabled,
  generic,
}
