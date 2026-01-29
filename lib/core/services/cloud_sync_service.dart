import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/game_constants.dart';
import '../constants/storage_keys.dart';
import '../constants/subscription_constants.dart';

// Top-level functions for compute
dynamic _parseJson(String jsonStr) => jsonDecode(jsonStr);
String _encodeJson(Object? data) => jsonEncode(data);

/// Service for syncing user data between local storage and Firebase Cloud Firestore
///
/// ## Sync Strategies:
/// - **syncToCloud()**: Upload local data to cloud (overwrites)
/// - **syncFromCloud()**: Download cloud data to local (overwrites)
/// - **smartSync()**: Intelligent merge - keeps better progress from both sources
///
/// ## Smart Merge Rules:
/// - **Word Progress**: Keep higher SRS level; if equal, keep higher review count
/// - **Pet Data**: Keep higher level; if equal, keep higher XP
/// - **Badges**: Union of all unlocked badges (never lose a badge)
/// - **Streak**: Keep higher best streak; use more recent activity for current
/// - **Error Log**: Union of entries; keep higher wrong count for duplicates
/// - **Arcade**: Keep higher scores and levels per game
/// - **Custom Words**: Union by ID (never lose a custom word)
class CloudSyncService {
  static final CloudSyncService _instance = CloudSyncService._internal();
  factory CloudSyncService() => _instance;
  CloudSyncService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  /// Get current user ID, returns null if not authenticated
  String? get _userId => _auth.currentUser?.uid;

  /// Check if user is authenticated
  bool get isAuthenticated => _userId != null;

  // ===========================================
  // FREE USER SYNC LIMITING
  // ===========================================

  /// Check if free user can sync (once per day limit)
  Future<bool> canFreeUserSync() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncStr = prefs.getString(StorageKeys.lastSyncLimitDate);
    if (lastSyncStr == null) return true;

    final lastSync = DateTime.tryParse(lastSyncStr);
    if (lastSync == null) return true;

    return DateTime.now().difference(lastSync) >=
        SubscriptionConstants.freeSyncCooldown;
  }

  /// Record sync usage for free user limit tracking
  Future<void> recordFreeSyncUsage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      StorageKeys.lastSyncLimitDate,
      DateTime.now().toIso8601String(),
    );
  }

  /// Get time until next free sync is available
  Future<Duration?> getTimeUntilNextFreeSync() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncStr = prefs.getString(StorageKeys.lastSyncLimitDate);
    if (lastSyncStr == null) return null;

    final lastSync = DateTime.tryParse(lastSyncStr);
    if (lastSync == null) return null;

    final nextSyncTime = lastSync.add(SubscriptionConstants.freeSyncCooldown);
    final remaining = nextSyncTime.difference(DateTime.now());

    return remaining.isNegative ? null : remaining;
  }

  /// Smart sync with premium check
  /// Returns true if local data was updated from cloud
  /// Throws [SyncLimitException] if free user has exceeded daily limit
  Future<bool> smartSyncWithPremiumCheck({required bool isPremium}) async {
    if (!isPremium) {
      final canSync = await canFreeUserSync();
      if (!canSync) {
        final remaining = await getTimeUntilNextFreeSync();
        throw SyncLimitException(
          'Free users can sync once per day',
          remainingTime: remaining,
        );
      }
    }

    final result = await smartSync();

    if (!isPremium) {
      await recordFreeSyncUsage();
    }

    return result;
  }

  /// Get user document reference
  DocumentReference? get _userDoc {
    final uid = _userId;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid);
  }

  /// Sync all user data to cloud
  /// Call this when user logs in or periodically
  Future<void> syncToCloud() async {
    if (!isAuthenticated) {
      debugPrint('CloudSync: Not authenticated, skipping upload');
      return;
    }

    try {
      debugPrint('CloudSync: Starting upload to cloud...');
      final prefs = await SharedPreferences.getInstance();

      // Prepare all data for upload
      final syncData = <String, dynamic>{
        'lastSyncAt': FieldValue.serverTimestamp(),
        'wordProgress': await _getJsonFromPrefs(prefs, StorageKeys.wordProgress),
        'customWords': await _getJsonFromPrefs(prefs, StorageKeys.customWordsData),
        'petData': await _getJsonFromPrefs(prefs, StorageKeys.petData),
        'hasPet': prefs.getBool(StorageKeys.hasPet) ?? false,
        'badges': await _getJsonFromPrefs(prefs, StorageKeys.userBadges),
        'streak': await _getJsonFromPrefs(prefs, StorageKeys.streakData),
        'errorLog': await _getJsonFromPrefs(prefs, StorageKeys.errorLogEntries),
        'arcade': _getArcadeData(prefs),
      };

      // Upload to Firestore
      await _userDoc!.set(syncData, SetOptions(merge: true));

      // Save sync timestamp locally
      await prefs.setString(StorageKeys.lastCloudSync, DateTime.now().toIso8601String());

      debugPrint('CloudSync: Upload completed successfully');
    } catch (e) {
      debugPrint('CloudSync: Upload failed: $e');
      rethrow;
    }
  }

  /// Sync all user data from cloud to local
  /// Call this when user logs in on a new device
  Future<void> syncFromCloud() async {
    if (!isAuthenticated) {
      debugPrint('CloudSync: Not authenticated, skipping download');
      return;
    }

    try {
      debugPrint('CloudSync: Starting download from cloud...');
      final prefs = await SharedPreferences.getInstance();

      // Get data from Firestore
      final doc = await _userDoc!.get();
      if (!doc.exists) {
        debugPrint('CloudSync: No cloud data found, nothing to restore');
        return;
      }

      final data = doc.data() as Map<String, dynamic>;

      // Restore word progress
      if (data['wordProgress'] != null) {
        await prefs.setString(
          StorageKeys.wordProgress,
          await compute(_encodeJson, data['wordProgress']),
        );
      }

      // Restore custom words
      if (data['customWords'] != null) {
        await prefs.setString(
          StorageKeys.customWordsData,
          await compute(_encodeJson, data['customWords']),
        );
      }

      // Restore pet data
      if (data['petData'] != null) {
        await prefs.setString(
          StorageKeys.petData,
          await compute(_encodeJson, data['petData']),
        );
      }
      if (data['hasPet'] != null) {
        await prefs.setBool(StorageKeys.hasPet, data['hasPet'] as bool);
      }

      // Restore badges
      if (data['badges'] != null) {
        await prefs.setString(
          StorageKeys.userBadges,
          await compute(_encodeJson, data['badges']),
        );
      }

      // Restore streak
      if (data['streak'] != null) {
        await prefs.setString(
          StorageKeys.streakData,
          await compute(_encodeJson, data['streak']),
        );
      }

      // Restore error log
      if (data['errorLog'] != null) {
        await prefs.setString(
          StorageKeys.errorLogEntries,
          await compute(_encodeJson, data['errorLog']),
        );
      }

      // Restore arcade data
      if (data['arcade'] != null) {
        await _restoreArcadeData(prefs, data['arcade'] as Map<String, dynamic>);
      }

      // Save sync timestamp
      await prefs.setString(StorageKeys.lastCloudSync, DateTime.now().toIso8601String());

      debugPrint('CloudSync: Download completed successfully');
    } catch (e) {
      debugPrint('CloudSync: Download failed: $e');
      rethrow;
    }
  }

  /// Smart sync: compares local and cloud data, keeps the more advanced progress
  /// Returns true if any data was updated locally from cloud
  Future<bool> smartSync() async {
    if (!isAuthenticated) {
      debugPrint('CloudSync: Not authenticated, skipping smart sync');
      return false;
    }

    try {
      debugPrint('CloudSync: Starting smart sync...');
      final prefs = await SharedPreferences.getInstance();

      // Get cloud data
      final doc = await _userDoc!.get();
      final hasCloudData = doc.exists && doc.data() != null;

      if (!hasCloudData) {
        // No cloud data, just upload local data
        debugPrint('CloudSync: No cloud data found, uploading local data');
        await syncToCloud();
        return false;
      }

      final cloudData = doc.data() as Map<String, dynamic>;

      // Run all merge operations in parallel for better performance
      final mergeResults = await Future.wait([
        _mergeWordProgress(prefs, cloudData),
        _mergePetData(prefs, cloudData),
        _mergeBadges(prefs, cloudData),
        _mergeStreak(prefs, cloudData),
        _mergeErrorLog(prefs, cloudData),
        _mergeArcade(prefs, cloudData),
        _mergeCustomWords(prefs, cloudData),
      ]);

      // Check if any merge operation updated local data
      final localDataUpdated = mergeResults.any((result) => result);

      // After merging, upload the merged data back to cloud
      await syncToCloud();

      debugPrint(
        'CloudSync: Smart sync completed. Local updated: $localDataUpdated',
      );
      return localDataUpdated;
    } catch (e) {
      debugPrint('CloudSync: Smart sync failed: $e');
      rethrow;
    }
  }

  /// Clear cloud data (for account deletion or reset)
  Future<void> clearCloudData() async {
    if (!isAuthenticated) return;

    try {
      await _userDoc!.delete();
      debugPrint('CloudSync: Cloud data cleared');
    } catch (e) {
      debugPrint('CloudSync: Failed to clear cloud data: $e');
      rethrow;
    }
  }

  /// Get last sync timestamp
  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(StorageKeys.lastCloudSync);
    if (timestamp == null) return null;
    return DateTime.tryParse(timestamp);
  }

  // ============================================================================
  // Helper methods
  // ============================================================================

  /// Get JSON data from SharedPreferences
  Future<dynamic> _getJsonFromPrefs(SharedPreferences prefs, String key) async {
    final jsonStr = prefs.getString(key);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    try {
      return await compute(_parseJson, jsonStr);
    } catch (e) {
      return null;
    }
  }

  /// Get arcade data from SharedPreferences
  Map<String, dynamic> _getArcadeData(SharedPreferences prefs) {
    final arcadeData = <String, dynamic>{};

    for (final game in GameConstants.arcadeGameTypes) {
      arcadeData['${game}_score'] =
          prefs.getInt('$StorageKeys.arcadeHighscorePrefix$game') ?? 0;
      arcadeData['${game}_level'] =
          prefs.getInt('$StorageKeys.arcadeLevelPrefix$game') ?? 0;
      arcadeData['${game}_progress'] =
          prefs.getStringList('$StorageKeys.arcadeProgressPrefix$game') ?? [];
    }

    return arcadeData;
  }

  /// Restore arcade data to SharedPreferences
  Future<void> _restoreArcadeData(
    SharedPreferences prefs,
    Map<String, dynamic> arcadeData,
  ) async {
    for (final game in GameConstants.arcadeGameTypes) {
      final score = arcadeData['${game}_score'] as int?;
      final level = arcadeData['${game}_level'] as int?;
      final progress = arcadeData['${game}_progress'];

      if (score != null) {
        await prefs.setInt('$StorageKeys.arcadeHighscorePrefix$game', score);
      }
      if (level != null) {
        await prefs.setInt('$StorageKeys.arcadeLevelPrefix$game', level);
      }
      if (progress != null && progress is List) {
        await prefs.setStringList(
          '$StorageKeys.arcadeProgressPrefix$game',
          progress.cast<String>(),
        );
      }
    }
  }

  // ============================================================================
  // Merge methods for smart sync
  // ============================================================================

  /// Merge word progress - keep higher SRS level and review count
  Future<bool> _mergeWordProgress(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.wordProgress);
    final cloudProgress = cloudData['wordProgress'];

    if (cloudProgress == null) return false;
    if (localJson == null) {
      await prefs.setString(
        StorageKeys.wordProgress,
        await compute(_encodeJson, cloudProgress),
      );
      return true;
    }

    final localProgress = localJson as Map<String, dynamic>;
    final cloud = cloudProgress as Map<String, dynamic>;
    bool updated = false;

    // Merge: for each word, keep the one with higher progress
    for (final entry in cloud.entries) {
      final wordId = entry.key;
      final cloudWord = entry.value as Map<String, dynamic>;

      if (!localProgress.containsKey(wordId)) {
        // Word doesn't exist locally, add it
        localProgress[wordId] = cloudWord;
        updated = true;
      } else {
        // Compare and keep higher progress
        final localWord = localProgress[wordId] as Map<String, dynamic>;
        final cloudSrs = cloudWord['srsLevel'] ?? 0;
        final localSrs = localWord['srsLevel'] ?? 0;
        final cloudReview = cloudWord['reviewCount'] ?? 0;
        final localReview = localWord['reviewCount'] ?? 0;

        // Keep cloud version if it has higher progress
        if (cloudSrs > localSrs ||
            (cloudSrs == localSrs && cloudReview > localReview)) {
          localProgress[wordId] = cloudWord;
          updated = true;
        }
      }
    }

    if (updated) {
      await prefs.setString(
        StorageKeys.wordProgress,
        await compute(_encodeJson, localProgress),
      );
    }
    return updated;
  }

  /// Merge pet data - keep higher level/XP
  Future<bool> _mergePetData(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.petData);
    final cloudPet = cloudData['petData'];
    final cloudHasPet = cloudData['hasPet'] ?? false;

    if (cloudPet == null || !cloudHasPet) return false;

    if (localJson == null || !(prefs.getBool(StorageKeys.hasPet) ?? false)) {
      // No local pet, use cloud
      await prefs.setString(StorageKeys.petData, await compute(_encodeJson, cloudPet));
      await prefs.setBool(StorageKeys.hasPet, true);
      return true;
    }

    final localPet = localJson as Map<String, dynamic>;
    final cloud = cloudPet as Map<String, dynamic>;

    final cloudLevel = cloud['level'] ?? 0;
    final localLevel = localPet['level'] ?? 0;
    final cloudXp = cloud['totalXp'] ?? 0;
    final localXp = localPet['totalXp'] ?? 0;

    // Keep the one with higher level/XP
    if (cloudLevel > localLevel ||
        (cloudLevel == localLevel && cloudXp > localXp)) {
      await prefs.setString(StorageKeys.petData, await compute(_encodeJson, cloudPet));
      return true;
    }

    return false;
  }

  /// Merge badges - union of all unlocked badges
  Future<bool> _mergeBadges(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.userBadges);
    final cloudBadges = cloudData['badges'];

    if (cloudBadges == null) return false;

    final localBadges = (localJson as Map<String, dynamic>?) ?? {};
    final cloud = cloudBadges as Map<String, dynamic>;
    bool updated = false;

    // Union: add any badges from cloud that aren't local
    for (final entry in cloud.entries) {
      if (!localBadges.containsKey(entry.key)) {
        localBadges[entry.key] = entry.value;
        updated = true;
      }
    }

    if (updated) {
      await prefs.setString(
        StorageKeys.userBadges,
        await compute(_encodeJson, localBadges),
      );
    }
    return updated;
  }

  /// Merge streak - keep higher best streak, update current appropriately
  Future<bool> _mergeStreak(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.streakData);
    final cloudStreak = cloudData['streak'];

    if (cloudStreak == null) return false;

    if (localJson == null) {
      await prefs.setString(
        StorageKeys.streakData,
        await compute(_encodeJson, cloudStreak),
      );
      return true;
    }

    final localData = localJson as Map<String, dynamic>;
    final cloud = cloudStreak as Map<String, dynamic>;

    final cloudBest = cloud['bestStreak'] ?? 0;
    final localBest = localData['bestStreak'] ?? 0;
    bool updated = false;

    // Keep higher best streak
    if (cloudBest > localBest) {
      localData['bestStreak'] = cloudBest;
      updated = true;
    }

    // Compare last activity dates to determine current streak
    final cloudLastStr = cloud['lastActivityDate'] as String?;
    final localLastStr = localData['lastActivityDate'] as String?;

    if (cloudLastStr != null && localLastStr != null) {
      final cloudLast = DateTime.parse(cloudLastStr);
      final localLast = DateTime.parse(localLastStr);

      // If cloud activity is more recent, use cloud current streak
      if (cloudLast.isAfter(localLast)) {
        localData['currentStreak'] = cloud['currentStreak'];
        localData['lastActivityDate'] = cloudLastStr;
        updated = true;
      }
    } else if (cloudLastStr != null && localLastStr == null) {
      localData['currentStreak'] = cloud['currentStreak'];
      localData['lastActivityDate'] = cloudLastStr;
      updated = true;
    }

    if (updated) {
      await prefs.setString(StorageKeys.streakData, await compute(_encodeJson, localData));
    }
    return updated;
  }

  /// Merge error log - union of all entries
  Future<bool> _mergeErrorLog(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.errorLogEntries);
    final cloudLog = cloudData['errorLog'];

    if (cloudLog == null) return false;

    if (localJson == null) {
      await prefs.setString(StorageKeys.errorLogEntries, await compute(_encodeJson, cloudLog));
      return true;
    }

    final localEntries = (localJson as List<dynamic>);
    final cloudEntries = (cloudLog as List<dynamic>);
    bool updated = false;

    // Create a map of local entries by word for quick lookup
    final localMap = <String, Map<String, dynamic>>{};
    for (final entry in localEntries) {
      final e = entry as Map<String, dynamic>;
      localMap[e['word'].toString().toLowerCase()] = e;
    }

    // Merge cloud entries
    for (final entry in cloudEntries) {
      final e = entry as Map<String, dynamic>;
      final word = e['word'].toString().toLowerCase();

      if (!localMap.containsKey(word)) {
        localEntries.add(e);
        updated = true;
      } else {
        // Keep higher wrong count
        final localEntry = localMap[word]!;
        final cloudCount = e['wrongCount'] ?? 0;
        final localCount = localEntry['wrongCount'] ?? 0;
        if (cloudCount > localCount) {
          localEntry['wrongCount'] = cloudCount;
          updated = true;
        }
      }
    }

    if (updated) {
      await prefs.setString(
        StorageKeys.errorLogEntries,
        await compute(_encodeJson, localEntries),
      );
    }
    return updated;
  }

  /// Merge arcade - keep higher scores/levels
  Future<bool> _mergeArcade(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final cloudArcade = cloudData['arcade'];
    if (cloudArcade == null) return false;

    final cloud = cloudArcade as Map<String, dynamic>;
    bool updated = false;

    for (final game in GameConstants.arcadeGameTypes) {
      // Merge scores - keep higher
      final cloudScore = cloud['${game}_score'] as int? ?? 0;
      final localScore = prefs.getInt('$StorageKeys.arcadeHighscorePrefix$game') ?? 0;
      if (cloudScore > localScore) {
        await prefs.setInt('$StorageKeys.arcadeHighscorePrefix$game', cloudScore);
        updated = true;
      }

      // Merge levels - keep higher
      final cloudLevel = cloud['${game}_level'] as int? ?? 0;
      final localLevel = prefs.getInt('$StorageKeys.arcadeLevelPrefix$game') ?? 0;
      if (cloudLevel > localLevel) {
        await prefs.setInt('$StorageKeys.arcadeLevelPrefix$game', cloudLevel);
        updated = true;
      }
    }

    return updated;
  }

  /// Merge custom words - union of all custom words
  Future<bool> _mergeCustomWords(
    SharedPreferences prefs,
    Map<String, dynamic> cloudData,
  ) async {
    final localJson = await _getJsonFromPrefs(prefs, StorageKeys.customWordsData);
    final cloudWords = cloudData['customWords'];

    if (cloudWords == null) return false;

    if (localJson == null) {
      await prefs.setString(
        StorageKeys.customWordsData,
        await compute(_encodeJson, cloudWords),
      );
      return true;
    }

    final localWords = (localJson as List<dynamic>);
    final cloud = (cloudWords as List<dynamic>);
    bool updated = false;

    // Create a set of local word IDs for quick lookup
    final localIds = <int>{};
    for (final word in localWords) {
      final w = word as Map<String, dynamic>;
      localIds.add(w['id'] as int);
    }

    // Add cloud words that don't exist locally
    for (final word in cloud) {
      final w = word as Map<String, dynamic>;
      final id = w['id'] as int;
      if (!localIds.contains(id)) {
        localWords.add(w);
        updated = true;
      }
    }

    if (updated) {
      await prefs.setString(
        StorageKeys.customWordsData,
        await compute(_encodeJson, localWords),
      );
    }
    return updated;
  }
}

/// Exception thrown when free user exceeds sync limit
class SyncLimitException implements Exception {
  final String message;
  final Duration? remainingTime;

  SyncLimitException(this.message, {this.remainingTime});

  @override
  String toString() => 'SyncLimitException: $message';

  /// Get human-readable remaining time
  String get remainingTimeText {
    if (remainingTime == null) return '';
    final hours = remainingTime!.inHours;
    final minutes = remainingTime!.inMinutes % 60;
    if (hours > 0) {
      return '$hours saat $minutes dakika';
    }
    return '$minutes dakika';
  }
}
