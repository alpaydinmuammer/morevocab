import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/exceptions/app_exceptions.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/cloud_sync_service.dart';
import '../../core/services/notification_service.dart';
import '../../domain/models/auth_state.dart';
import '../providers/word_providers.dart';
import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  bool _isNavigating = false;
  bool _isDataReady = false;
  DateTime? _animationFinishTime;
  late Animation<double> _moreVocabOpacity;

  // Card animations - more sophisticated
  late Animation<double> _card1Slide;
  late Animation<double> _card1Rotate;
  late Animation<double> _card1Opacity;
  late Animation<double> _card1Scale;

  late Animation<double> _card2Slide;
  late Animation<double> _card2Rotate;
  late Animation<double> _card2Opacity;
  late Animation<double> _card2Scale;

  late Animation<double> _card3Slide;
  late Animation<double> _card3Rotate;
  late Animation<double> _card3Opacity;
  late Animation<double> _card3Scale;

  @override
  void initState() {
    super.initState();

    // Main animation controller - optimized for faster transition
    _mainController = AnimationController(
      vsync: this,
      duration: AppConstants.splashMainAnimationDuration,
    );

    _setupAnimations();

    _mainController.addListener(() {
      _tryNavigate();
    });

    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _tryNavigate();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start main animation quickly
      Future.delayed(AppConstants.splashInitialDelay, () {
        if (mounted) _mainController.forward();
      });

      // Delay heavy data loading slightly
      Future.delayed(AppConstants.splashDataLoadDelay, () {
        _initializeData();
      });
    });
  }

  bool _imagesPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_imagesPrecached) {
      _imagesPrecached = true;
      _precacheCriticalImages();
    }
  }

  /// Precache critical images to prevent frame drops during navigation
  void _precacheCriticalImages() {
    // Logo
    precacheImage(const AssetImage(AppConstants.logoAssetPath), context);
    precacheImage(
      const AssetImage('assets/images/logo/morevocabicon.png'),
      context,
    );

    // Deck images
    precacheImage(const AssetImage('assets/images/decks/sat.png'), context);
    precacheImage(
      const AssetImage('assets/images/decks/strategy.png'),
      context,
    );
    precacheImage(const AssetImage('assets/images/decks/ielts.png'), context);
    precacheImage(const AssetImage('assets/images/decks/toefl.png'), context);

    // Arcade game thumbnails
    precacheImage(
      const AssetImage('assets/images/arcade/word_chain.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/arcade/anagram.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/arcade/word_builder.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/arcade/emoji_puzzle.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/arcade/odd_one_out.png'),
      context,
    );
  }

  void _setupAnimations() {
    // Card 1 (Top) - Enhanced with scale
    _card1Slide = Tween<double>(begin: 0.0, end: 120.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );
    _card1Rotate = Tween<double>(begin: -0.05, end: 0.25).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _card1Opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _card1Scale = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Card 2 (Middle)
    _card2Slide = Tween<double>(begin: 0.0, end: -120.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _card2Rotate = Tween<double>(begin: 0.05, end: -0.25).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    _card2Opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    _card2Scale = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    // Card 3 (Bottom)
    _card3Slide = Tween<double>(begin: 0.0, end: 120.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _card3Rotate = Tween<double>(begin: -0.02, end: 0.25).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );
    _card3Opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );
    _card3Scale = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );

    // More Vocab text animation
    _moreVocabOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  Future<void> _initializeData() async {
    try {
      // Start notification initialization in background (don't await)
      // Firebase is already initialized in main.dart
      unawaited(NotificationService().initialize());

      // Initialize word repository
      final repository = ref.read(wordRepositoryProvider);
      final result = await repository.init().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Data loading timeout');
        },
      );

      result.when(
        success: (_) {
          _isDataReady = true;
          _tryNavigate();
        },
        failure: (_) {
          _isDataReady = true;
          _tryNavigate();
        },
      );
    } catch (e) {
      _isDataReady = true;
      _tryNavigate();
    }
  }

  void _tryNavigate() {
    if (!mounted || _isNavigating) return;

    // Navigate when cards animation is done and More Vocab text is shown
    bool animationFinished = _mainController.value >= 1.0;

    if (animationFinished && _isDataReady) {
      _isNavigating = true;
      _navigateBasedOnAuthState();
    } else if (animationFinished && !_isDataReady) {
      _animationFinishTime ??= DateTime.now();
      final waitTime = DateTime.now().difference(_animationFinishTime!);
      // Reduced wait time for faster fallback
      if (waitTime.inMilliseconds >= 1500) {
        _isNavigating = true;
        _navigateBasedOnAuthState();
      }
    }
  }

  void _navigateBasedOnAuthState() {
    final authState = ref.read(authStateProvider);
    final isGuest = ref.read(guestModeProvider);
    final settings = ref.read(settingsProvider);

    authState.when(
      data: (state) async {
        final isAuthenticated = state is AuthAuthenticated;
        final canAccess = isAuthenticated || isGuest;

        if (!canAccess) {
          // Not logged in -> go to auth
          if (mounted) context.go('/auth');
        } else {
          // If authenticated (not guest), sync data from cloud
          if (isAuthenticated) {
            await _performCloudSync();
          }

          if (!mounted) return;

          if (!settings.hasSeenOnboarding) {
            // First time -> go to onboarding
            context.go('/onboarding');
          } else {
            // Returning user -> go to home
            context.go('/');
          }
        }
      },
      loading: () {
        // Auth still loading, go to auth page
        context.go('/auth');
      },
      error: (_, _) {
        // On error, go to auth page
        context.go('/auth');
      },
    );
  }

  /// Perform cloud sync for returning authenticated users
  Future<void> _performCloudSync() async {
    try {
      final cloudSync = CloudSyncService();
      final updated = await cloudSync.smartSync();
      if (updated) {
        debugPrint('Splash: Cloud data restored to local');
      }
    } catch (e) {
      debugPrint('Splash: Cloud sync failed: $e');
      // Don't block navigation on sync failure
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          return Stack(
            children: [
              // Animated gradient background
              _buildAnimatedBackground(),

              // Main content
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Logo (appears behind cards)
                    Opacity(
                      opacity: _moreVocabOpacity.value,
                      child: Image.asset(
                        AppConstants.logoAssetPath,
                        width: 280,
                        height: 280,
                      ),
                    ),

                    // Card Stack Area (in front)
                    _buildCardStack(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Container(color: AppTheme.darkBackground);
  }

  Widget _buildCardStack() {
    return SizedBox(
      height: 200,
      width: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Card 3 (Bottom Card)
          _buildAnimatedCard(
            slide: _card3Slide,
            rotate: _card3Rotate,
            opacity: _card3Opacity,
            scale: _card3Scale,
            color: AppTheme.secondaryColor.withValues(alpha: 0.9),
            index: 2,
          ),

          // Card 2 (Middle Card)
          _buildAnimatedCard(
            slide: _card2Slide,
            rotate: _card2Rotate,
            opacity: _card2Opacity,
            scale: _card2Scale,
            color: const Color(0xFF4ECDC4),
            index: 1,
          ),

          // Card 1 (Top Card)
          _buildAnimatedCard(
            slide: _card1Slide,
            rotate: _card1Rotate,
            opacity: _card1Opacity,
            scale: _card1Scale,
            color: AppTheme.primaryColor,
            index: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard({
    required Animation<double> slide,
    required Animation<double> rotate,
    required Animation<double> opacity,
    required Animation<double> scale,
    required Color color,
    required int index,
  }) {
    // Opacity based optimization
    if (opacity.value <= 0.01) return const SizedBox.shrink();

    // Spread Tilt logic
    double staticTilt = 0.0;
    if (index == 1) staticTilt = -0.05;
    if (index == 2) staticTilt = 0.05;

    return Opacity(
      opacity: opacity.value,
      child: Transform.translate(
        offset: Offset(slide.value, 0),
        child: Transform.rotate(
          angle: rotate.value + staticTilt,
          child: Transform.scale(
            scale: scale.value,
            child: Container(
              width: 90,
              height: 120,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  index == 0
                      ? 'get'
                      : index == 1
                      ? 'more'
                      : 'vocab',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.3,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
