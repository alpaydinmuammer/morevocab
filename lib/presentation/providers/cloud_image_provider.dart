import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/cloud_image_service.dart';
import '../../domain/models/word_card.dart';

/// State for deck download progress
class DeckDownloadState {
  final String? currentlyDownloading;
  final int downloadedCount;
  final int totalCount;
  final Set<String> downloadedDecks;
  final bool isLoading;
  final String? error;

  const DeckDownloadState({
    this.currentlyDownloading,
    this.downloadedCount = 0,
    this.totalCount = 0,
    this.downloadedDecks = const {},
    this.isLoading = false,
    this.error,
  });

  double get progress =>
      totalCount > 0 ? downloadedCount / totalCount : 0;

  bool isDeckDownloaded(String deckName) => downloadedDecks.contains(deckName);

  DeckDownloadState copyWith({
    String? currentlyDownloading,
    int? downloadedCount,
    int? totalCount,
    Set<String>? downloadedDecks,
    bool? isLoading,
    String? error,
  }) {
    return DeckDownloadState(
      currentlyDownloading: currentlyDownloading,
      downloadedCount: downloadedCount ?? this.downloadedCount,
      totalCount: totalCount ?? this.totalCount,
      downloadedDecks: downloadedDecks ?? this.downloadedDecks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing deck downloads
class DeckDownloadNotifier extends StateNotifier<DeckDownloadState> {
  final CloudImageService _cloudService;

  DeckDownloadNotifier(this._cloudService) : super(const DeckDownloadState()) {
    _loadDownloadedDecks();
  }

  Future<void> _loadDownloadedDecks() async {
    state = state.copyWith(isLoading: true);
    final downloaded = await _cloudService.getDownloadedDecks();
    state = state.copyWith(
      downloadedDecks: downloaded.toSet(),
      isLoading: false,
    );
  }

  /// Download images for a deck
  Future<void> downloadDeck(String deckName, List<WordCard> words) async {
    if (state.currentlyDownloading != null) {
      return; // Already downloading
    }

    // Collect all CDN URLs for this deck
    final urls = <String>[];
    for (final word in words) {
      final url = _cloudService.getImageUrl(word.localAsset, word.imageUrl);
      if (url != null) {
        urls.add(url);
      }
    }

    if (urls.isEmpty) {
      // No images to download, mark as downloaded
      await _cloudService.markDeckAsDownloaded(deckName);
      state = state.copyWith(
        downloadedDecks: {...state.downloadedDecks, deckName},
      );
      return;
    }

    state = state.copyWith(
      currentlyDownloading: deckName,
      downloadedCount: 0,
      totalCount: urls.length,
      error: null,
    );

    try {
      await _cloudService.preloadImages(
        urls,
        onProgress: (downloaded, total) {
          state = state.copyWith(
            downloadedCount: downloaded,
            totalCount: total,
          );
        },
      );

      await _cloudService.markDeckAsDownloaded(deckName);
      state = state.copyWith(
        currentlyDownloading: null,
        downloadedDecks: {...state.downloadedDecks, deckName},
        downloadedCount: 0,
        totalCount: 0,
      );
    } catch (e) {
      state = state.copyWith(
        currentlyDownloading: null,
        error: e.toString(),
        downloadedCount: 0,
        totalCount: 0,
      );
    }
  }

  /// Cancel current download (not implemented yet)
  void cancelDownload() {
    // TODO: Implement cancellation
    state = state.copyWith(
      currentlyDownloading: null,
      downloadedCount: 0,
      totalCount: 0,
    );
  }

  /// Remove a deck from downloaded (clear its cache)
  Future<void> removeDeck(String deckName) async {
    await _cloudService.removeDeckFromDownloaded(deckName);
    final newDownloaded = Set<String>.from(state.downloadedDecks);
    newDownloaded.remove(deckName);
    state = state.copyWith(downloadedDecks: newDownloaded);
  }

  /// Clear all cached images
  Future<void> clearAllCache() async {
    await _cloudService.clearCache();
    state = state.copyWith(downloadedDecks: {});
  }

  /// Refresh downloaded decks list
  Future<void> refresh() async {
    await _loadDownloadedDecks();
  }
}

/// Provider for CloudImageService
final cloudImageServiceProvider = Provider<CloudImageService>((ref) {
  return CloudImageService();
});

/// Provider for deck download state
final deckDownloadProvider =
    StateNotifierProvider<DeckDownloadNotifier, DeckDownloadState>((ref) {
  final cloudService = ref.watch(cloudImageServiceProvider);
  return DeckDownloadNotifier(cloudService);
});

/// Provider to check if a specific deck is downloaded
final isDeckDownloadedProvider = Provider.family<bool, String>((ref, deckName) {
  final state = ref.watch(deckDownloadProvider);
  return state.isDeckDownloaded(deckName);
});

/// Provider for current download progress (0.0 - 1.0)
final downloadProgressProvider = Provider<double>((ref) {
  final state = ref.watch(deckDownloadProvider);
  return state.progress;
});
