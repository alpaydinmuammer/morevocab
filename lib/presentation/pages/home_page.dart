import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/word_providers.dart';
import '../providers/settings_provider.dart';
import '../providers/pet_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/premium_background.dart';
import '../widgets/deck_stats_carousel.dart';
import '../widgets/credits_modal.dart';
import '../widgets/pet/pet_widgets.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/streak_badge.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      body: PremiumBackground(
        showTypo: true, // User updated: Keep original letters AND add G/M
        child: Stack(
          children: [
            // ... decorative letters ...
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Greeting + name - tap to edit name
                              GestureDetector(
                                onTap: () => _showUserNameDialog(context, ref),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        settings.userName.isNotEmpty
                                            ? '${homeState.getGreeting(AppLocalizations.of(context)!)}, ${settings.userName}'
                                            : homeState.getGreeting(
                                                AppLocalizations.of(context)!,
                                              ),
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme.colorScheme.primary,
                                              fontSize:
                                                  settings.userName.length > 6
                                                  ? AppConstants
                                                        .greetingFontSizeLongName
                                                  : AppConstants
                                                        .greetingFontSizeShortName,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Edit icon - only show if no name entered yet
                                    if (settings.userName.isEmpty) ...[
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.edit_rounded,
                                        size: 20,
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.7),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                homeState.getMotivationalPhrase(
                                  AppLocalizations.of(context)!,
                                ),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: theme.brightness == Brightness.dark
                                        ? 0.8
                                        : 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const StreakBadge(),
                      ],
                    ),

                    const Expanded(flex: 1, child: SizedBox()),

                    // Pet Widget
                    _buildPetSection(context, ref),

                    const SizedBox(height: 16),

                    // Main Deck Carousel
                    const DeckStatsCarousel(),

                    const SizedBox(height: 16),

                    const Expanded(flex: 1, child: SizedBox()),

                    // Start Study Button
                    _buildStartButton(context, ref),

                    const SizedBox(height: 12),

                    // Arcade & Settings Row
                    Row(
                      children: [
                        Expanded(child: _buildArcadeButton(context)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSettingsButton(context)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Credits button
                    TextButton.icon(
                      onPressed: () => _showCredits(context),
                      icon: Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.credits,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetSection(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petProvider);

    // Show loading state
    if (petState.isLoading) {
      return const SizedBox(height: AppConstants.petSectionHeight);
    }

    // Show egg if no pet exists
    if (!petState.hasPet) {
      return PetEggWidget(onTap: () => _showPetSelection(context));
    }

    // Show pet display
    return const PetDisplayWidget();
  }

  void _showPetSelection(BuildContext context) async {
    final result = await PetSelectionModal.show(context);
    if (result == true) {
      // Pet was created successfully
    }
  }

  Widget _buildStartButton(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AnimatedPressable(
      onTap: () async {
        await context.push('/decks');
        ref.invalidate(wordStatsProvider);
      },
      child: Container(
        width: double.infinity,
        height: AppConstants.startButtonHeight, // Taller button for card feel
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment
              .center, // CRITICAL FIX: Center content vertically/horizontally
          children: [
            // Background Icon Decoration
            Positioned(
              right: -5,
              bottom: -5,
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 64,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center everything
                children: [
                  // Icon (Cleaner, no box)
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 12),

                  // Text ONLY (No subtitle, no column needed)
                  Text(
                    AppLocalizations.of(context)!.start.toUpperCase(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArcadeButton(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedPressable(
      onTap: () => context.push('/arcade'),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: theme.extension<AppColors>()!.arcadeGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.extension<AppColors>()!.arcadeShadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Icon Decoration
            Positioned(
              right: -5,
              bottom: -5,
              child: Icon(
                Icons.videogame_asset_rounded,
                size: 60,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sports_esports_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.arcadeMode.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCredits(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: true,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: AppConstants.creditsModalTransition,
      ),
      builder: (context) => const CreditsModal(),
    );
  }

  void _showUserNameDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final theme = Theme.of(context);
    final settings = ref.read(settingsProvider);

    controller.text = settings.userName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.editName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          maxLength: AppConstants.maxUserNameLength,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.enterYourName,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.person_rounded),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              ref.read(settingsProvider.notifier).setUserName(name);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedPressable(
      onTap: () => context.push('/settings'),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: theme.extension<AppColors>()!.settingsGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.extension<AppColors>()!.settingsShadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Icon Decoration
            Positioned(
              right: -5,
              bottom: -5,
              child: Icon(
                Icons.settings_suggest_rounded,
                size: 60,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.settings_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.settings.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
