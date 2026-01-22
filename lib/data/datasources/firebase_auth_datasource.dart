import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

import '../../domain/models/user_model.dart';
import '../../domain/models/auth_state.dart';

/// Datasource for Firebase Authentication operations
class FirebaseAuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static FirebaseAuthDatasource? _instance;

  FirebaseAuthDatasource._({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  /// Singleton factory
  factory FirebaseAuthDatasource() {
    _instance ??= FirebaseAuthDatasource._(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(
        scopes: ['email', 'profile'],
      ),
    );
    return _instance!;
  }

  /// Stream of auth state changes
  Stream<AuthState> get authStateStream {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return const AuthUnauthenticated();
      }
      return AuthAuthenticated(_mapFirebaseUser(user));
    });
  }

  /// Get current Firebase user
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  /// Get current user model
  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  /// Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'sign-in-cancelled',
          message: 'Google sign-in was cancelled',
        );
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-null',
          message: 'Failed to get user after sign-in',
        );
      }

      return _mapFirebaseUser(user, provider: AuthProvider.google);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'google-sign-in-failed',
        message: e.toString(),
      );
    }
  }

  /// Sign in with Apple
  Future<UserModel> signInWithApple() async {
    try {
      // Generate nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request Apple credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create OAuth credential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      final user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-null',
          message: 'Failed to get user after Apple sign-in',
        );
      }

      // Apple may provide name only on first sign-in
      // Update display name if provided
      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        final displayName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                .trim();
        if (displayName.isNotEmpty && user.displayName == null) {
          await user.updateDisplayName(displayName);
        }
      }

      return _mapFirebaseUser(user, provider: AuthProvider.apple);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw FirebaseAuthException(
          code: 'sign-in-cancelled',
          message: 'Apple sign-in was cancelled',
        );
      }
      throw FirebaseAuthException(
        code: 'apple-sign-in-failed',
        message: e.message,
      );
    } catch (e) {
      throw FirebaseAuthException(
        code: 'apple-sign-in-failed',
        message: e.toString(),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  /// Map Firebase User to UserModel
  UserModel _mapFirebaseUser(User user, {AuthProvider? provider}) {
    // Determine provider from Firebase user if not specified
    final authProvider = provider ?? _determineProvider(user);

    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      provider: authProvider,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastSignInAt: user.metadata.lastSignInTime,
    );
  }

  /// Determine auth provider from Firebase user
  AuthProvider _determineProvider(User user) {
    for (final info in user.providerData) {
      if (info.providerId == 'google.com') {
        return AuthProvider.google;
      }
      if (info.providerId == 'apple.com') {
        return AuthProvider.apple;
      }
    }
    return AuthProvider.google; // Default fallback
  }

  /// Generate random nonce for Apple Sign-In
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// SHA256 hash for nonce
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Check if Apple Sign-In is available on this platform
  static bool get isAppleSignInAvailable {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }
}

/// Custom exception for Firebase Auth errors
class FirebaseAuthException implements Exception {
  final String code;
  final String message;

  FirebaseAuthException({required this.code, required this.message});

  AuthErrorType get errorType {
    switch (code) {
      case 'network-request-failed':
        return AuthErrorType.network;
      case 'sign-in-cancelled':
        return AuthErrorType.cancelled;
      case 'invalid-credential':
        return AuthErrorType.invalidCredential;
      case 'user-disabled':
        return AuthErrorType.userDisabled;
      default:
        return AuthErrorType.generic;
    }
  }

  @override
  String toString() => 'FirebaseAuthException($code): $message';
}
