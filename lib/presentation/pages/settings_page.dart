import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../providers/pet_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/word_providers.dart';
import '../widgets/premium_background.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: PremiumBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          children: [
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.theme,
              Icons.palette_outlined,
            ),
            _buildGlassCard(
              context,
              child: _buildThemeSelector(context, ref, settings.themeMode),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.language,
              Icons.language_rounded,
            ),
            _buildGlassCard(
              context,
              padding: EdgeInsets.zero,
              child: _buildLanguageSelector(context, ref, settings.locale),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.data,
              Icons.storage_rounded,
            ),
            _buildGlassCard(
              context,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_sweep_rounded,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.resetProgress,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.resetDescription,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                onTap: () => _showResetConfirmation(context, ref),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard(
    BuildContext context, {
    required Widget child,
    EdgeInsets? padding,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : theme.colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) {
    final theme = Theme.of(context);

    Widget buildChip(String label, ThemeMode mode, IconData icon) {
      final isSelected = currentMode == mode;
      return Expanded(
        child: AnimatedPressable(
          onTap: () => ref.read(settingsProvider.notifier).setThemeMode(mode),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        buildChip(
          AppLocalizations.of(context)!.system,
          ThemeMode.system,
          Icons.brightness_auto_rounded,
        ),
        const SizedBox(width: 8),
        buildChip(
          AppLocalizations.of(context)!.light,
          ThemeMode.light,
          Icons.light_mode_rounded,
        ),
        const SizedBox(width: 8),
        buildChip(
          AppLocalizations.of(context)!.dark,
          ThemeMode.dark,
          Icons.dark_mode_rounded,
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
  ) {
    final languages = [
      {
        'code': 'tr',
        'flag': '🇹🇷',
        'name': AppLocalizations.of(context)!.turkish,
      },
      {
        'code': 'en',
        'flag': '🇺🇸',
        'name': AppLocalizations.of(context)!.english,
      },
      {
        'code': 'es',
        'flag': '🇪🇸',
        'name': AppLocalizations.of(context)!.spanish,
      },
      {
        'code': 'fr',
        'flag': '🇫🇷',
        'name': AppLocalizations.of(context)!.french,
      },
      {
        'code': 'de',
        'flag': '🇩🇪',
        'name': AppLocalizations.of(context)!.german,
      },
      {
        'code': 'it',
        'flag': '🇮🇹',
        'name': AppLocalizations.of(context)!.italian,
      },
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSupported = lang['code'] == 'tr' || lang['code'] == 'en';
          final isSelected = currentLocale.languageCode == lang['code'];
          final theme = Theme.of(context);

          return Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSupported ? 1.0 : 0.5,
                  child: AnimatedPressable(
                    onTap: isSupported
                        ? () {
                            ref
                                .read(settingsProvider.notifier)
                                .setLocale(Locale(lang['code']!));
                          }
                        : null,
                    child: Container(
                      width: 85,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isSupported
                            ? (isSelected
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.secondary.withValues(
                                      alpha: 0.05,
                                    ))
                            : theme.colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSupported
                              ? (isSelected
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.secondary.withValues(
                                        alpha: 0.1,
                                      ))
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang['flag']!,
                            style: TextStyle(
                              fontSize: 28,
                              color: isSupported ? null : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lang['name']!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSupported
                                  ? (isSelected
                                        ? Colors.white
                                        : theme.colorScheme.onSurface)
                                  : theme.colorScheme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isSupported)
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.comingSoon,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showResetConfirmation(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          AppLocalizations.of(context)!.resetProgress,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(AppLocalizations.of(context)!.resetConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.reset),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(wordRepositoryProvider).resetProgress();
      await ref.read(petProvider.notifier).deletePet(); // Also reset pet
      ref.invalidate(wordStatsProvider);
      ref.invalidate(wordStudyProvider);
      ref.invalidate(petProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.resetSuccess),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }
}
