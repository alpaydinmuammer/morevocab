/// CDN configuration constants for cloud-hosted images
class CdnConstants {
  CdnConstants._();

  /// Base URL for CDN - Cloudflare R2 with custom domain
  static const String baseUrl = 'https://cdn.morevocab.com';

  /// Image path prefix
  static const String imagesPath = '/images/words';

  /// Supported image formats
  static const String imageFormat = 'webp';

  /// Cache duration for images (in days)
  static const int cacheDurationDays = 30;

  /// Maximum cache size in MB
  static const int maxCacheSizeMB = 500;

  /// Placeholder image asset path (local fallback)
  static const String placeholderAsset = 'assets/images/logo/morevocabappicon.png';

  /// Build full CDN URL for a word image
  /// Example: https://cdn.morevocab.com/images/words/beginner/word_hello_123.webp
  static String getImageUrl(String deck, String fileName) {
    return '$baseUrl$imagesPath/$deck/$fileName';
  }

  /// Extract deck and filename from local asset path
  /// Input: assets/images/words/beginner/word_hello_123.webp
  /// Output: (beginner, word_hello_123.webp)
  static (String deck, String fileName)? parseLocalAsset(String localAsset) {
    final regex = RegExp(r'assets/images/words/([^/]+)/(.+)$');
    final match = regex.firstMatch(localAsset);
    if (match != null) {
      return (match.group(1)!, match.group(2)!);
    }
    return null;
  }

  /// Convert local asset path to CDN URL
  static String? localAssetToCdnUrl(String localAsset) {
    final parsed = parseLocalAsset(localAsset);
    if (parsed != null) {
      return getImageUrl(parsed.$1, parsed.$2);
    }
    return null;
  }
}
