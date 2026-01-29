/// Constants for notification service configuration
class NotificationConstants {
  NotificationConstants._();

  // ===========================================
  // ANDROID NOTIFICATION CHANNEL
  // ===========================================
  static const channelId = 'more_vocab_channel';
  static const channelName = 'More Vocab Notifications';
  static const channelDescription = 'Vocabulary learning reminders and updates';

  // ===========================================
  // NOTIFICATION IDS
  // ===========================================
  static const userDailyReminderId = 0;
  static const autoDailyReminderId = 1;

  // ===========================================
  // DEFAULT REMINDER TIMES
  // ===========================================
  static const defaultReminderHour = 20; // 8 PM
  static const defaultReminderMinute = 0;
}
