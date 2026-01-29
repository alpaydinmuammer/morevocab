import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdService {
  // Singleton pattern
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoading = false;
  int _interstitialCounter = 0;
  static const int _interstitialFrequency = 3;

  // Test Ad Unit IDs
  String get bannerAdUnitId {
    if (kDebugMode && Platform.isAndroid) {
      return dotenv.env['ADMOB_BANNER_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544/6300978111';
    } else if (kDebugMode && Platform.isIOS) {
      return dotenv.env['ADMOB_BANNER_ID_IOS'] ??
          'ca-app-pub-3940256099942544/2934735716';
    }

    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_BANNER_ID_ANDROID'] ?? '';
    } else {
      return dotenv.env['ADMOB_BANNER_ID_IOS'] ?? '';
    }
  }

  String get interstitialAdUnitId {
    if (kDebugMode && Platform.isAndroid) {
      return dotenv.env['ADMOB_INTERSTITIAL_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544/1033173712';
    } else if (kDebugMode && Platform.isIOS) {
      return dotenv.env['ADMOB_INTERSTITIAL_ID_IOS'] ??
          'ca-app-pub-3940256099942544/4411468910';
    }

    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_INTERSTITIAL_ID_ANDROID'] ?? '';
    } else {
      return dotenv.env['ADMOB_INTERSTITIAL_ID_IOS'] ?? '';
    }
  }

  /// Initialize the Mobile Ads SDK
  Future<void> init() async {
    await MobileAds.instance.initialize();

    // Allow test devices if needed (optional for emulator)
    // MobileAds.instance.updateRequestConfiguration(...)

    // Preload an interstitial ad
    loadInterstitial();
  }

  /// Load an interstitial ad
  void loadInterstitial() {
    if (_isInterstitialLoading || _interstitialAd != null) return;

    _isInterstitialLoading = true;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _interstitialAd = ad;
          _isInterstitialLoading = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          _interstitialAd = null;
          _isInterstitialLoading = false;
        },
      ),
    );
  }

  /// Show the interstitial ad if available
  /// [checkFrequency] if true, only show every 3rd time
  void showInterstitial({
    VoidCallback? onAdDismissed,
    bool checkFrequency = true,
  }) {
    if (checkFrequency) {
      _interstitialCounter++;
      if (_interstitialCounter < _interstitialFrequency) {
        onAdDismissed?.call();
        return;
      }
      _interstitialCounter = 0;
    }

    if (_interstitialAd == null) {
      debugPrint('Warning: Attempted to show interstitial before loaded.');
      onAdDismissed?.call();
      loadInterstitial(); // Try loading again for next time
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) =>
          debugPrint('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _interstitialAd = null;
        loadInterstitial(); // Preload the next one
        onAdDismissed?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _interstitialAd = null;
        loadInterstitial();
        onAdDismissed?.call();
      },
    );

    _interstitialAd!.show();
  }

  /// Create a BannerAd instance
  BannerAd createBannerAd({required Function(Ad) onAdLoaded}) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );
  }
}
