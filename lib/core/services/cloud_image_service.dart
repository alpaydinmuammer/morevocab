import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cdn_constants.dart';
import '../constants/storage_keys.dart';

/// Service for managing cloud-hosted images with local caching
class CloudImageService {
  static final CloudImageService _instance = CloudImageService._internal();
  factory CloudImageService() => _instance;
  CloudImageService._internal();

  late final CacheManager _cacheManager;
  bool _initialized = false;

  /// Custom cache manager for word images
  CacheManager get cacheManager => _cacheManager;

  /// Initialize the cloud image service
  Future<void> initialize() async {
    if (_initialized) return;

    _cacheManager = CacheManager(
      Config(
        'morevocab_images',
        stalePeriod: Duration(days: CdnConstants.cacheDurationDays),
        maxNrOfCacheObjects: 5000, // Support up to 5000 cached images
      ),
    );

    _initialized = true;
  }

  /// Get image URL - returns CDN URL if available, falls back to checking local asset
  String? getImageUrl(String? localAsset, String? imageUrl) {
    // If already has a CDN URL, use it
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return imageUrl;
    }

    // Convert local asset path to CDN URL
    if (localAsset != null && localAsset.isNotEmpty) {
      return CdnConstants.localAssetToCdnUrl(localAsset);
    }

    return null;
  }

  /// Check if an image is cached locally
  Future<bool> isImageCached(String url) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(url);
      return fileInfo != null;
    } catch (e) {
      return false;
    }
  }

  /// Preload a single image
  Future<void> preloadImage(String url) async {
    try {
      await _cacheManager.downloadFile(url);
    } catch (_) {
      // Silently fail - image will be loaded on demand
    }
  }

  /// Preload multiple images (for deck download)
  Future<void> preloadImages(
    List<String> urls, {
    void Function(int downloaded, int total)? onProgress,
  }) async {
    int downloaded = 0;
    final total = urls.length;

    for (final url in urls) {
      try {
        await _cacheManager.downloadFile(url);
        downloaded++;
        onProgress?.call(downloaded, total);
      } catch (_) {
        downloaded++;
        onProgress?.call(downloaded, total);
      }
    }
  }

  /// Get cache size in bytes
  Future<int> getCacheSize() async {
    try {
      // Get the cache directory path
      final cacheDir = await _cacheManager.store.getCacheSize();
      return cacheDir;
    } catch (e) {
      return 0;
    }
  }

  /// Clear all cached images
  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }

  /// Remove cached images for a specific deck
  Future<void> clearDeckCache(String deckName) async {
    // Note: CacheManager doesn't support selective deletion by URL pattern
    // This is a limitation - we can only clear all or nothing
    await clearCache();
  }

  /// Mark a deck as downloaded
  Future<void> markDeckAsDownloaded(String deckName) async {
    final prefs = await SharedPreferences.getInstance();
    final downloaded = prefs.getStringList(StorageKeys.downloadedDecks) ?? [];
    if (!downloaded.contains(deckName)) {
      downloaded.add(deckName);
      await prefs.setStringList(StorageKeys.downloadedDecks, downloaded);
    }
  }

  /// Check if a deck is downloaded
  Future<bool> isDeckDownloaded(String deckName) async {
    final prefs = await SharedPreferences.getInstance();
    final downloaded = prefs.getStringList(StorageKeys.downloadedDecks) ?? [];
    return downloaded.contains(deckName);
  }

  /// Get list of downloaded decks
  Future<List<String>> getDownloadedDecks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(StorageKeys.downloadedDecks) ?? [];
  }

  /// Remove a deck from downloaded list
  Future<void> removeDeckFromDownloaded(String deckName) async {
    final prefs = await SharedPreferences.getInstance();
    final downloaded = prefs.getStringList(StorageKeys.downloadedDecks) ?? [];
    downloaded.remove(deckName);
    await prefs.setStringList(StorageKeys.downloadedDecks, downloaded);
  }
}
