import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LeaderboardEntry {
  final String userId;
  final String displayName;
  final int score;
  final DateTime timestamp;
  final int? rank;

  LeaderboardEntry({
    required this.userId,
    required this.displayName,
    required this.score,
    required this.timestamp,
    this.rank,
  });

  factory LeaderboardEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeaderboardEntry(
      userId: doc.id,
      displayName: data['displayName'] ?? 'Unknown',
      score: data['score'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class LeaderboardService {
  static final LeaderboardService _instance = LeaderboardService._internal();
  factory LeaderboardService() => _instance;
  LeaderboardService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;
  String? get _displayName =>
      _auth.currentUser?.displayName ??
      _auth.currentUser?.email?.split('@')[0] ??
      'Player';

  /// Update user's score on leaderboard
  /// Only premium users can submit scores to the leaderboard
  /// [isPremium] - Whether the user has a premium subscription
  Future<void> updateScore(
    String gameId,
    int score, {
    required bool isPremium,
  }) async {
    // Only premium users can appear on leaderboard
    if (!isPremium) {
      debugPrint('Leaderboard: Free user, score not submitted');
      return;
    }

    final uid = _userId;
    if (uid == null) return;

    try {
      final docRef = _firestore
          .collection('leaderboards')
          .doc(gameId)
          .collection('scores')
          .doc(uid);

      // Check current high score
      final docKey = await docRef.get();
      if (docKey.exists) {
        final currentScore =
            (docKey.data() as Map<String, dynamic>)['score'] as int? ?? 0;
        if (score <= currentScore) {
          return; // New score is not higher
        }
      }

      // Update if higher
      await docRef.set({
        'userId': uid,
        'displayName': _displayName,
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('Leaderboard: Score updated for $gameId: $score');
    } catch (e) {
      debugPrint('Leaderboard: Failed to update score: $e');
    }
  }

  Future<List<LeaderboardEntry>> getTopScores(
    String gameId, {
    int limit = 20,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('leaderboards')
          .doc(gameId)
          .collection('scores')
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs.asMap().entries.map((entry) {
        final doc = entry.value;
        final rank = entry.key + 1;
        final item = LeaderboardEntry.fromFirestore(doc);
        // We return a new object to attach the rank, since it's not in DB
        return LeaderboardEntry(
          userId: item.userId,
          displayName: item.displayName,
          score: item.score,
          timestamp: item.timestamp,
          rank: rank,
        );
      }).toList();
    } catch (e) {
      debugPrint('Leaderboard: Failed to fetch scores: $e');
      return [];
    }
  }

  Future<LeaderboardEntry?> getUserScore(String gameId) async {
    final uid = _userId;
    if (uid == null) return null;

    try {
      final doc = await _firestore
          .collection('leaderboards')
          .doc(gameId)
          .collection('scores')
          .doc(uid)
          .get();

      if (!doc.exists) return null;
      return LeaderboardEntry.fromFirestore(doc);
    } catch (e) {
      debugPrint('Leaderboard: Failed to fetch user score: $e');
      return null;
    }
  }

  // DEBUG ONLY: In-memory fake scores
  final List<LeaderboardEntry> _fakeScores = [];

  // DEBUG ONLY: Add fake score for testing
  Future<void> debugAddFakeScore(String gameId, String name, int score) async {
    final fakeUid = 'fake_${DateTime.now().millisecondsSinceEpoch}';

    // Add to local list immediately for UI testing
    _fakeScores.add(
      LeaderboardEntry(
        userId: fakeUid,
        displayName: name,
        score: score,
        timestamp: DateTime.now(),
      ),
    );

    // Sort fake scores
    _fakeScores.sort((a, b) => b.score.compareTo(a.score));

    debugPrint('Leaderboard: Fake score added locally: $name - $score');

    try {
      await _firestore
          .collection('leaderboards')
          .doc(gameId)
          .collection('scores')
          .doc(fakeUid)
          .set({
            'userId': fakeUid,
            'displayName': name,
            'score': score,
            'timestamp': FieldValue.serverTimestamp(),
          });
      debugPrint('Leaderboard: Fake score added to Firestore: $name - $score');
    } catch (e) {
      debugPrint('Leaderboard: Failed to save fake score to Firestore: $e');
    }
  }
}
