/// Authentication provider types
enum AuthProvider {
  google,
  apple,
}

/// Extension for AuthProvider
extension AuthProviderExtension on AuthProvider {
  String get displayName {
    switch (this) {
      case AuthProvider.google:
        return 'Google';
      case AuthProvider.apple:
        return 'Apple';
    }
  }
}

/// Immutable model representing an authenticated user
class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final AuthProvider provider;
  final DateTime createdAt;
  final DateTime? lastSignInAt;

  const UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.provider,
    required this.createdAt,
    this.lastSignInAt,
  });

  /// Create a copy with updated values
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    AuthProvider? provider,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'provider': provider.name,
      'createdAt': createdAt.toIso8601String(),
      'lastSignInAt': lastSignInAt?.toIso8601String(),
    };
  }

  /// Create from JSON (Firestore document)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      provider: AuthProvider.values.firstWhere(
        (e) => e.name == json['provider'],
        orElse: () => AuthProvider.google,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] != null
          ? DateTime.parse(json['lastSignInAt'] as String)
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.provider == provider;
  }

  @override
  int get hashCode {
    return Object.hash(uid, email, displayName, photoUrl, provider);
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, provider: ${provider.displayName})';
  }
}
