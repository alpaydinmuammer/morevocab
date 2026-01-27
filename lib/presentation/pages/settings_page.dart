import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/cloud_sync_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/firebase_auth_datasource.dart';
import '../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/pet_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/word_providers.dart';
import '../providers/error_log_provider.dart';
import '../widgets/auth/sign_in_button.dart';
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
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 24),
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

            const SizedBox(height: AppConstants.spacingXXXL),
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

            const SizedBox(height: AppConstants.spacingXXXL),
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
                  padding: const EdgeInsets.all(8),
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

            const SizedBox(height: AppConstants.spacingXXXL),
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.notifications,
              Icons.notifications_outlined,
            ),
            _buildGlassCard(
              context,
              padding: EdgeInsets.zero,
              child: const _NotificationSettings(),
            ),

            // Cloud Sync section - only show for authenticated users
            if (ref.watch(isAuthenticatedProvider)) ...[
              const SizedBox(height: AppConstants.spacingXXXL),
              _buildSectionHeader(
                context,
                AppLocalizations.of(context)!.cloudSync,
                Icons.cloud_sync_outlined,
              ),
              _buildGlassCard(
                context,
                padding: EdgeInsets.zero,
                child: const _CloudSyncSettings(),
              ),
            ],

            const SizedBox(height: AppConstants.spacingXXXL),
            // Show Sign In for guests, Sign Out for authenticated users
            _buildAuthSection(context, ref),
            const SizedBox(height: AppConstants.spacingHuge),
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
      padding: const EdgeInsets.only(
        left: AppConstants.spacingXXS,
        bottom: AppConstants.spacingSM, // Reduced from MD
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppConstants.iconSizeXS,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(width: AppConstants.spacingSM),
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
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : theme.colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16), // Reduced from XLarge
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.4),
          width: 1.0, // Reduced from 1.5
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
            padding: const EdgeInsets.symmetric(vertical: 8),
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
                const SizedBox(height: AppConstants.spacingXXS),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppConstants.textSM,
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
        const SizedBox(width: AppConstants.spacingSM),
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
      height: 90,
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
                      width: 70,
                      height: 68,
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
                              fontSize: 24,
                              color: isSupported ? null : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingXXS),
                          Text(
                            lang['name']!,
                            style: TextStyle(
                              fontSize: AppConstants.textSXS,
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
                          fontSize: AppConstants.textTiny,
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

  Widget _buildAuthSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isGuest = ref.watch(guestModeProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    // Guest user - show Sign In option
    if (isGuest && !isAuthenticated) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            context,
            AppLocalizations.of(context)!.signIn,
            Icons.login_rounded,
          ),
          _buildGlassCard(
            context,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.login_rounded,
                  color: theme.colorScheme.primary,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.signIn,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              onTap: () => _signInFromGuest(context, ref),
            ),
          ),
        ],
      );
    }

    // Authenticated user - show Sign Out option
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          AppLocalizations.of(context)!.signOut,
          Icons.logout_rounded,
        ),
        _buildGlassCard(
          context,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout_rounded, color: theme.colorScheme.error),
            ),
            title: Text(
              AppLocalizations.of(context)!.signOut,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            onTap: () => _showSignOutConfirmation(context, ref),
          ),
        ),
      ],
    );
  }

  void _signInFromGuest(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _SignInModal(),
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
      await ref.read(errorLogProvider.notifier).clearAll(); // Clear error log
      ref.invalidate(wordStatsProvider);
      ref.invalidate(wordStudyProvider);
      ref.invalidate(petProvider);
      ref.invalidate(errorLogProvider);

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

  Future<void> _showSignOutConfirmation(
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
          AppLocalizations.of(context)!.signOut,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(AppLocalizations.of(context)!.signOutConfirm),
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
                backgroundColor: theme.colorScheme.error,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.signOut),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref.read(authNotifierProvider.notifier).signOut();

      if (success && context.mounted) {
        context.go('/auth');
      }
    }
  }
}

/// Notification settings widget
class _NotificationSettings extends StatefulWidget {
  const _NotificationSettings();

  @override
  State<_NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<_NotificationSettings> {
  final _notificationService = NotificationService();
  bool _notificationsEnabled = true;
  bool _dailyReminderEnabled = false;
  int _reminderHour = 20;
  int _reminderMinute = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final notificationsEnabled = await _notificationService
        .areNotificationsEnabled();
    final dailyReminderEnabled = await _notificationService
        .isDailyReminderEnabled();
    final reminderTime = await _notificationService.getDailyReminderTime();

    if (mounted) {
      setState(() {
        _notificationsEnabled = notificationsEnabled;
        _dailyReminderEnabled = dailyReminderEnabled;
        _reminderHour = reminderTime.hour;
        _reminderMinute = reminderTime.minute;
      });
    }
  }

  Future<void> _toggleNotifications(bool enabled) async {
    setState(() => _notificationsEnabled = enabled);
    await _notificationService.setNotificationsEnabled(enabled);

    if (!enabled) {
      setState(() => _dailyReminderEnabled = false);
      await _notificationService.setDailyReminderEnabled(false);
    }
  }

  Future<void> _toggleDailyReminder(bool enabled) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _dailyReminderEnabled = enabled);
    await _notificationService.setDailyReminderEnabled(enabled);

    if (enabled) {
      await _notificationService.scheduleDailyReminder(
        hour: _reminderHour,
        minute: _reminderMinute,
        title: l10n.dailyReminderTitle,
        body: l10n.dailyReminderBody,
      );
    }
  }

  Future<void> _selectTime() async {
    final l10n = AppLocalizations.of(context)!;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _reminderHour, minute: _reminderMinute),
    );

    if (picked != null && mounted) {
      setState(() {
        _reminderHour = picked.hour;
        _reminderMinute = picked.minute;
      });

      await _notificationService.setDailyReminderTime(
        picked.hour,
        picked.minute,
      );

      if (_dailyReminderEnabled) {
        await _notificationService.scheduleDailyReminder(
          hour: picked.hour,
          minute: picked.minute,
          title: l10n.dailyReminderTitle,
          body: l10n.dailyReminderBody,
        );
      }
    }
  }

  String _formatTime(int hour, int minute) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Push Notifications Toggle
        SwitchListTile(
          secondary: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
          title: Text(
            l10n.notificationsEnabled,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            l10n.notificationsEnabledDesc,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          value: _notificationsEnabled,
          onChanged: _toggleNotifications,
        ),

        if (_notificationsEnabled) ...[
          Divider(
            height: 1,
            indent: 72,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          ),

          // Daily Reminder Toggle
          SwitchListTile(
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.alarm_outlined,
                color: theme.colorScheme.secondary,
              ),
            ),
            title: Text(
              l10n.dailyReminder,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              l10n.dailyReminderDesc,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            value: _dailyReminderEnabled,
            onChanged: _toggleDailyReminder,
          ),

          if (_dailyReminderEnabled) ...[
            Divider(
              height: 1,
              indent: 72,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            ),

            // Reminder Time Picker
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.schedule_outlined,
                  color: theme.colorScheme.tertiary,
                ),
              ),
              title: Text(
                l10n.reminderTime,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                l10n.reminderTimeDesc,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatTime(_reminderHour, _reminderMinute),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: _selectTime,
            ),
          ],
        ],
      ],
    );
  }
}

/// Cloud sync settings widget
class _CloudSyncSettings extends StatefulWidget {
  const _CloudSyncSettings();

  @override
  State<_CloudSyncSettings> createState() => _CloudSyncSettingsState();
}

class _CloudSyncSettingsState extends State<_CloudSyncSettings> {
  final _cloudSync = CloudSyncService();
  bool _isSyncing = false;
  DateTime? _lastSyncTime;

  @override
  void initState() {
    super.initState();
    _loadLastSyncTime();
  }

  Future<void> _loadLastSyncTime() async {
    final lastSync = await _cloudSync.getLastSyncTime();
    if (mounted) {
      setState(() => _lastSyncTime = lastSync);
    }
  }

  Future<void> _performSync() async {
    setState(() => _isSyncing = true);

    try {
      await _cloudSync.smartSync();
      await _loadLastSyncTime();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.syncSuccess),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.syncFailed),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  String _formatLastSync() {
    if (_lastSyncTime == null) {
      return AppLocalizations.of(context)!.neverSynced;
    }

    final now = DateTime.now();
    final diff = now.difference(_lastSyncTime!);

    if (diff.inMinutes < 1) {
      return AppLocalizations.of(context)!.justNow;
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${AppLocalizations.of(context)!.minutesAgo}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${AppLocalizations.of(context)!.hoursAgo}';
    } else {
      return '${diff.inDays} ${AppLocalizations.of(context)!.daysAgo}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: _isSyncing
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              )
            : Icon(Icons.cloud_sync_outlined, color: theme.colorScheme.primary),
      ),
      title: Text(
        l10n.syncNow,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${l10n.lastSync}: ${_formatLastSync()}',
        style: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: _isSyncing
          ? null
          : Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
      onTap: _isSyncing ? null : _performSync,
    );
  }
}

/// Sign-in modal for guest users
class _SignInModal extends ConsumerStatefulWidget {
  const _SignInModal();

  @override
  ConsumerState<_SignInModal> createState() => _SignInModalState();
}

class _SignInModalState extends ConsumerState<_SignInModal> {
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithGoogle();

    if (mounted) {
      setState(() => _isGoogleLoading = false);

      if (success) {
        // Clear guest mode and close modal
        await ref.read(guestModeProvider.notifier).clearGuestMode();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        _showErrorSnackBar();
      }
    }
  }

  Future<void> _signInWithApple() async {
    setState(() => _isAppleLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithApple();

    if (mounted) {
      setState(() => _isAppleLoading = false);

      if (success) {
        // Clear guest mode and close modal
        await ref.read(guestModeProvider.notifier).clearGuestMode();
        if (mounted) {
          Navigator.pop(context);
        }
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
    final isAppleAvailable = FirebaseAuthDatasource.isAppleSignInAvailable;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppTheme.darkBackground
            : theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                l10n.signIn,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Sign-in buttons
              SignInButton(
                type: SignInButtonType.google,
                onPressed: _signInWithGoogle,
                isLoading: _isGoogleLoading,
              ),
              if (isAppleAvailable) ...[
                const SizedBox(height: 16),
                SignInButton(
                  type: SignInButtonType.apple,
                  onPressed: _signInWithApple,
                  isLoading: _isAppleLoading,
                ),
              ],
              const SizedBox(height: 16),

              // Cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.cancel,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
