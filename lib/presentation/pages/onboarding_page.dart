import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';

/// Premium onboarding page shown on first app launch
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();

    _bgController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    ref.read(settingsProvider.notifier).setHasSeenOnboarding(true);
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Animated Background
          _buildAnimatedBackground(theme),

          // 2. Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Skip button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          l10n.onboardingSkip,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.6)
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                            fontSize: AppConstants.textLG,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Page content
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      children: [
                        _buildWelcomePage(l10n),
                        _buildSwipePage(l10n),
                        _buildSrsPage(l10n),
                        _buildPetPage(l10n),
                        _buildDecksPage(l10n),
                        _buildStartPage(l10n),
                      ],
                    ),
                  ),

                  // 3. Bottom Controls (No Glass)
                  _buildBottomControls(l10n, theme, isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ThemeData theme) {
    // Cache screen height to avoid MediaQuery calls in animation
    final screenHeight = MediaQuery.of(context).size.height;

    // RepaintBoundary isolates this animation from the rest of the widget tree
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          // Pre-calculate sin/cos values once per frame
          final animValue = _bgController.value * 2 * math.pi;
          final sinVal = math.sin(animValue);
          final cosVal = math.cos(animValue);

          return Stack(
            children: [
              // Base background (static - passed as child)
              child!,

              // Blob 1 (Top Left - Primary Color)
              Positioned(
                top: -100 + (sinVal * 50),
                left: -50 + (cosVal * 30),
                child: _buildBlob(
                  color: theme.primaryColor.withValues(alpha: 0.5),
                  size: 400,
                ),
              ),

              // Blob 2 (Bottom Right - Secondary Color)
              Positioned(
                bottom: -50 + (cosVal * 50),
                right: -100 + (sinVal * 30),
                child: _buildBlob(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.5),
                  size: 300,
                ),
              ),

              // Blob 3 (Center - Accent)
              Positioned(
                top: screenHeight * 0.4 + (sinVal * 30),
                right: -50,
                child: _buildBlob(
                  color: Colors.purple.withValues(alpha: 0.3),
                  size: 200,
                ),
              ),

              // Light gradient overlay for soft atmosphere (replaces expensive BackdropFilter)
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.5,
                    colors: [
                      Colors.transparent,
                      theme.extension<AppColors>()!.onboardingGradientStart.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        // Static child that doesn't need to rebuild
        child: Container(
          color: theme.extension<AppColors>()!.onboardingGradientStart,
        ),
      ),
    );
  }

  Widget _buildBlob({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: 60, spreadRadius: 40)],
      ),
    );
  }

  Widget _buildBottomControls(
    AppLocalizations l10n,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingXXS,
                ),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppTheme.primaryColor
                      : (isDark
                            ? Colors.white.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          // Next/Start button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                _currentPage == 5 ? l10n.onboardingStart : l10n.onboardingNext,
                style: const TextStyle(
                  fontSize: AppConstants.textXL,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Page 1: Welcome - Logo and tagline
  Widget _buildWelcomePage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App logo
          Image.asset(
            'assets/images/logo/morevocabicon.png',
            width: 180,
            height: 180,
          ),
          const SizedBox(height: AppConstants.spacingSM),
          // Title
          Text(
            l10n.onboardingWelcomeTitle,
            style: TextStyle(
              fontSize: AppConstants.textHero,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLG),
          // Subtitle
          Text(
            l10n.onboardingWelcomeSubtitle,
            style: TextStyle(
              fontSize: AppConstants.textXL,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Page 2: Swipe to Learn - Two screenshots with 3D perspective
  Widget _buildSwipePage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            l10n.onboardingSwipeTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            l10n.onboardingSwipeSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Two screenshots with 3D perspective
          SizedBox(
            height: 280,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // I Don't Know screenshot (left, tilted)
                Positioned(
                  left: 40,
                  child: _build3DScreenshot(
                    'assets/images/onboarding slides/swipe-screen_idontknow.png',
                    rotationY: 0.15,
                    glowColor: Colors.red,
                  ),
                ),
                // I Know screenshot (right, tilted opposite)
                Positioned(
                  right: 40,
                  child: _build3DScreenshot(
                    'assets/images/onboarding slides/swipe-screen_iknow.png',
                    rotationY: -0.15,
                    glowColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build3DScreenshot(
    String imagePath, {
    required double rotationY,
    required Color glowColor,
  }) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Perspective
        ..rotateY(rotationY),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: glowColor.withValues(alpha: 0.4),
              blurRadius: 25,
              spreadRadius: 2,
              offset: Offset(rotationY > 0 ? -8 : 8, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(imagePath, height: 240, fit: BoxFit.contain),
        ),
      ),
    );
  }

  // Page 3: SRS Algorithm - Text only
  Widget _buildSrsPage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with glow
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF6B6B).withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B6B).withValues(alpha: 0.6),
                  blurRadius: 50,
                  spreadRadius: 20,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology_rounded,
              size: 100,
              color: Color(0xFFFF6B6B),
            ),
          ),
          const SizedBox(height: 40),
          // Title
          Text(
            l10n.onboardingSrsTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            l10n.onboardingSrsSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Page 4: Pet Companion - Screenshot with 3D effect
  Widget _buildPetPage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            l10n.onboardingPetTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            l10n.onboardingPetSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Pet selection screenshot with 3D perspective
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-0.05)
              ..rotateY(-0.08),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFE66D).withValues(alpha: 0.35),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(10, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(5, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/onboarding slides/pet-selection-page.png',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Page 5: Word Decks - Screenshot with 3D effect
  Widget _buildDecksPage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            l10n.onboardingDecksTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            l10n.onboardingDecksSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Deck selection screenshot with 3D perspective (opposite tilt)
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-0.05)
              ..rotateY(0.08),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF45B7D1).withValues(alpha: 0.35),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(-10, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(-5, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/onboarding slides/deck-selection-page.png',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Page 6: Start - Ready to begin
  Widget _buildStartPage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with glow
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF96CEB4).withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF96CEB4).withValues(alpha: 0.6),
                  blurRadius: 50,
                  spreadRadius: 20,
                ),
              ],
            ),
            child: const Icon(
              Icons.rocket_launch_rounded,
              size: 100,
              color: Color(0xFF96CEB4),
            ),
          ),
          const SizedBox(height: 40),
          // Title
          Text(
            l10n.onboardingReadyTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            l10n.onboardingReadySubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
