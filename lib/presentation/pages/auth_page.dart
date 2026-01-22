import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth/sign_in_button.dart';
import '../widgets/auth/language_selector.dart';

/// Premium authentication page for Google and Apple Sign-In
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage>
    with TickerProviderStateMixin {
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;
  bool _isGuestLoading = false;

  /// Check if any auth operation is in progress
  bool get _isAnyLoading => _isGoogleLoading || _isAppleLoading || _isGuestLoading;

  late AnimationController _fadeController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // Fade in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    // Floating animation for logo
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    if (_isAnyLoading) return; // Prevent multiple taps
    setState(() => _isGoogleLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithGoogle();

    if (mounted) {
      setState(() => _isGoogleLoading = false);

      if (success) {
        // Navigate to home/onboarding on successful sign-in
        context.go('/');
      } else {
        _showErrorSnackBar();
      }
    }
  }

  Future<void> _signInWithApple() async {
    if (_isAnyLoading) return; // Prevent multiple taps
    setState(() => _isAppleLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithApple();

    if (mounted) {
      setState(() => _isAppleLoading = false);

      if (success) {
        // Navigate to home/onboarding on successful sign-in
        context.go('/');
      } else {
        _showErrorSnackBar();
      }
    }
  }

  void _showErrorSnackBar() {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.read(authNotifierProvider);

    String message = l10n.authErrorGeneric;
    if (authState.hasError) {
      final error = authState.error.toString();
      if (error.contains('cancelled') || error.contains('canceled')) {
        message = l10n.authErrorCancelled;
      } else if (error.contains('network') || error.contains('connection')) {
        message = l10n.authErrorNetwork;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAppleAvailable = ref.watch(isAppleSignInAvailableProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          _buildAnimatedBackground(),

          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.12),

                    // Animated floating logo (transparent icon)
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: child,
                        );
                      },
                      child: _buildLogo(),
                    ),

                    const SizedBox(height: 32),

                    // App name with gradient
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Color(0xFF4ECDC4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        AppConstants.appName,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tagline
                    Text(
                      l10n.authTagline,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white60,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // Sign-in buttons with glass container
                    _buildSignInSection(isAppleAvailable),

                    const SizedBox(height: 24),

                    // Terms notice
                    Text(
                      l10n.authTermsNotice,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white38,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
          // Language Selector (Top Right)
          const SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 16, right: 24),
                child: LanguageSelector(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A1628),
            AppTheme.darkBackground,
            Color(0xFF0D2137),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: CustomPaint(
        painter: _BackgroundPatternPainter(),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.25),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/logo/morevocabicon.png',
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSignInSection(bool isAppleAvailable) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          SignInButton(
            type: SignInButtonType.google,
            onPressed: _signInWithGoogle,
            isLoading: _isGoogleLoading,
            disabled: _isAppleLoading || _isGuestLoading,
          ),
          if (isAppleAvailable) ...[
            const SizedBox(height: 16),
            SignInButton(
              type: SignInButtonType.apple,
              onPressed: _signInWithApple,
              isLoading: _isAppleLoading,
              disabled: _isGoogleLoading || _isGuestLoading,
            ),
          ],
          const SizedBox(height: 20),
          // Divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.orText,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Guest button
          GestureDetector(
            onTap: _isAnyLoading ? null : _continueAsGuest,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isAnyLoading ? 0.4 : 1.0,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: _isGuestLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                          ),
                        )
                      : Text(
                          l10n.continueAsGuest,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _continueAsGuest() async {
    if (_isAnyLoading) return; // Prevent tap while auth in progress
    setState(() => _isGuestLoading = true);

    await ref.read(guestModeProvider.notifier).setGuestMode(true);
    if (mounted) {
      context.go('/');
    }
  }
}

/// Background pattern painter
class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw accent circles only (removed grid pattern)
    final accentPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      150,
      accentPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      100,
      accentPaint..color = AppTheme.secondaryColor.withValues(alpha: 0.05),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
