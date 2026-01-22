import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/word_providers.dart';
import '../providers/settings_provider.dart';
import '../providers/pet_provider.dart';
import '../widgets/premium_background.dart';
import '../widgets/deck_stats_carousel.dart';
import '../widgets/credits_modal.dart';
import '../widgets/pet/pet_widgets.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/time_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  /// Returns time-based greeting based on current hour
  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= TimeConstants.morningStartHour &&
        hour < TimeConstants.morningEndHour) {
      return l10n.goodMorning; // 05:00 - 11:59 → Günaydın
    } else if (hour >= TimeConstants.afternoonStartHour &&
        hour < TimeConstants.afternoonEndHour) {
      return l10n.goodAfternoon; // 12:00 - 17:59 → İyi Günler
    } else if (hour >= TimeConstants.eveningStartHour &&
        hour < TimeConstants.eveningEndHour) {
      return l10n.goodEvening; // 18:00 - 21:59 → İyi Akşamlar
    } else {
      return l10n.goodNight; // 22:00 - 04:59 → İyi Geceler
    }
  }

  /// Returns day-based motivational phrase (with special late night override)
  String _getMotivationalPhrase(AppLocalizations l10n) {
    final now = DateTime.now();
    final hour = now.hour;
    final weekday = now.weekday;

    // Special message for 02:00-02:59 on Monday, Thursday, Sunday
    if (hour == TimeConstants.specialMotivationalHour &&
        (weekday == DateTime.monday ||
            weekday == DateTime.thursday ||
            weekday == DateTime.sunday)) {
      return l10n.motive2am;
    }

    // Special message for 03:00-04:59 (late night)
    if (hour >= TimeConstants.lateNightStartHour &&
        hour < TimeConstants.lateNightEndHour) {
      return l10n.motiveLateNight;
    }

    // Day-based phrases
    switch (weekday) {
      case DateTime.monday:
        return l10n.motiveMon;
      case DateTime.tuesday:
        return l10n.motiveTue;
      case DateTime.wednesday:
        return l10n.motiveWed;
      case DateTime.thursday:
        return l10n.motiveThu;
      case DateTime.friday:
        return l10n.motiveFri;
      case DateTime.saturday:
        return l10n.motiveSat;
      case DateTime.sunday:
        return l10n.motiveSun;
      default:
        return l10n.letsLearn;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

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
                                            ? '${_getGreeting(AppLocalizations.of(context)!)}, ${settings.userName}'
                                            : _getGreeting(
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
                                _getMotivationalPhrase(
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
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.settings_suggest_rounded,
                              color: Colors.indigo,
                            ),
                            onPressed: () => context.push('/settings'),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Pet Widget
                    _buildPetSection(context, ref),

                    const SizedBox(height: 16),

                    // Main Deck Carousel
                    const DeckStatsCarousel(),

                    const Spacer(),

                    // Start Study Button
                    _buildStartButton(context, ref),

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
              right: -10,
              bottom: -10,
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 80,
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
                    size: 32,
                  ),
                  const SizedBox(width: 16),

                  // Text ONLY (No subtitle, no column needed)
                  Text(
                    AppLocalizations.of(context)!.start.toUpperCase(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontSize: 24, // Slightly bigger since it's alone
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
}
