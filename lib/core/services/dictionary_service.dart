import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Service for validating words using Free Dictionary API
/// with offline fallback support
class DictionaryService {
  static const _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  // Cache for word validations to reduce API calls
  static final Map<String, bool> _cache = {};

  // Offline word list (loaded from asset)
  static Set<String>? _offlineWords;

  // Whether to use offline mode
  static bool _offlineMode = false;

  /// Check if device has internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final response = await http
          .get(
            Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/test'),
          )
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Enable offline mode and load word list from asset
  static Future<void> enableOfflineMode() async {
    _offlineMode = true;
    await _loadOfflineWordList();
  }

  /// Disable offline mode (use API)
  static void enableOnlineMode() {
    _offlineMode = false;
  }

  /// Check if currently in offline mode
  static bool get isOfflineMode => _offlineMode;

  /// Load offline word list from asset file
  static Future<void> _loadOfflineWordList() async {
    if (_offlineWords != null) return;

    try {
      final String wordData = await rootBundle.loadString(
        'assets/data/english_words.txt',
      );
      _offlineWords = wordData
          .split('\n')
          .map((w) => w.trim().toLowerCase())
          .where((w) => w.length >= 3)
          .toSet();
    } catch (e) {
      _offlineWords = {};
    }
  }

  /// Check if a word is valid
  /// Uses API in online mode, local word list in offline mode
  static Future<bool> isValidWord(String word) async {
    if (word.isEmpty || word.length < 3) return false;

    final lowerWord = word.toLowerCase();

    // Check cache first
    if (_cache.containsKey(lowerWord)) {
      return _cache[lowerWord]!;
    }

    // Offline mode: use local word list
    if (_offlineMode) {
      await _loadOfflineWordList();
      final isValid = _offlineWords?.contains(lowerWord) ?? false;
      _cache[lowerWord] = isValid;
      return isValid;
    }

    // Online mode: use API
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/$lowerWord'))
          .timeout(const Duration(seconds: 5));

      final isValid = response.statusCode == 200;
      _cache[lowerWord] = isValid;
      return isValid;
    } catch (e) {
      // Network error - try offline fallback
      await _loadOfflineWordList();
      return _offlineWords?.contains(lowerWord) ?? true;
    }
  }

  /// Clear the validation cache
  static void clearCache() {
    _cache.clear();
  }
}
