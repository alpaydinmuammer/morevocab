/// Centralized SharedPreferences keys for consistent storage access
class StorageKeys {
  StorageKeys._();

  // ===========================================
  // SETTINGS
  // ===========================================
  static const locale = 'locale';
  static const themeMode = 'theme_mode';
  static const ttsRate = 'tts_rate';
  static const ttsVolume = 'tts_volume';
  static const ttsPitch = 'tts_pitch';
  static const userName = 'user_name';
  static const hasSeenOnboarding = 'has_seen_onboarding';

  // ===========================================
  // WORD PROGRESS
  // ===========================================
  static const wordProgress = 'word_progress';
  static const customWordsData = 'custom_words_data';

  // ===========================================
  // STREAK
  // ===========================================
  static const streakData = 'user_streak_data';

  // ===========================================
  // ERROR LOG
  // ===========================================
  static const errorLogEntries = 'error_log_entries';

  // ===========================================
  // PET
  // ===========================================
  static const petData = 'pet_data';
  static const hasPet = 'has_pet';

  // ===========================================
  // BADGES
  // ===========================================
  static const userBadges = 'user_badges';

  // ===========================================
  // CHALLENGES
  // ===========================================
  static const challengesLastReset = 'challenges_last_reset';
  static const challengeCompletedPrefix = 'challenge_completed_';

  // ===========================================
  // ARCADE
  // ===========================================
  static const arcadeHighscorePrefix = 'arcade_highscore_';
  static const arcadeLevelPrefix = 'arcade_level_';
  static const arcadeProgressPrefix = 'arcade_progress_';

  // ===========================================
  // NOTIFICATIONS
  // ===========================================
  static const notificationsEnabled = 'notifications_enabled';
  static const dailyReminderEnabled = 'daily_reminder_enabled';
  static const dailyReminderHour = 'daily_reminder_hour';
  static const dailyReminderMinute = 'daily_reminder_minute';

  // ===========================================
  // CLOUD SYNC
  // ===========================================
  static const lastCloudSync = 'last_cloud_sync';
  static const lastSyncLimitDate = 'last_sync_limit_date';

  // ===========================================
  // SUBSCRIPTION
  // ===========================================
  static const subscriptionStatus = 'subscription_status';

  // ===========================================
  // CDN / DOWNLOADED CONTENT
  // ===========================================
  static const downloadedDecks = 'downloaded_decks';
  static const imageCacheSize = 'image_cache_size';

  // ===========================================
  // SOUND
  // ===========================================
  static const soundEnabled = 'sound_enabled';
  static const soundVolume = 'sound_volume';
}
