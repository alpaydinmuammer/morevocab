import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Background message handler - must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  debugPrint('Handling a background message: ${message.messageId}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Prevent duplicate stream subscriptions
  bool _isInitialized = false;

  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _dailyReminderEnabledKey = 'daily_reminder_enabled';
  static const String _dailyReminderHourKey = 'daily_reminder_hour';
  static const String _dailyReminderMinuteKey = 'daily_reminder_minute';

  // Notification IDs
  static const int _userDailyReminderId = 0;
  static const int _autoDailyReminderId = 1;

  // Default auto reminder time (20:00 / 8 PM)
  static const int _autoReminderHour = 20;
  static const int _autoReminderMinute = 0;

  // Notification channel for Android
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'more_vocab_channel',
    'More Vocab Notifications',
    description: 'Vocabulary learning reminders and updates',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  /// Initialize the notification service
  Future<void> initialize() async {
    // Prevent duplicate initialization (and duplicate stream subscriptions)
    if (_isInitialized) return;
    _isInitialized = true;

    // Initialize timezone
    tz_data.initializeTimeZones();

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Request permissions
    await _requestPermissions();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);
    }

    // Configure foreground message presentation options for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background/terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Check if app was opened from a notification
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }

    // Get and print FCM token for debugging
    final token = await getToken();
    debugPrint('FCM Token: $token');

    // Schedule automatic daily reminder (always active)
    await scheduleAutoDailyReminder();
  }

  /// Schedule automatic daily reminder that runs regardless of user settings
  /// This ensures users get at least one reminder per day
  Future<void> scheduleAutoDailyReminder() async {
    // Check if notifications are completely disabled
    final notificationsEnabled = await areNotificationsEnabled();
    if (!notificationsEnabled) {
      debugPrint('Auto daily reminder skipped - notifications disabled');
      return;
    }

    // Cancel existing auto reminder
    await _localNotifications.cancel(id: _autoDailyReminderId);

    // Schedule automatic daily reminder at default time
    try {
      await _localNotifications.zonedSchedule(
        id: _autoDailyReminderId,
        title: 'Bugün kelime çalıştın mı?',
        body: 'Sadece 5 dakika ayır, fark yaratır!',
        scheduledDate: _nextInstanceOfTime(
          _autoReminderHour,
          _autoReminderMinute,
        ),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('Error scheduling auto daily reminder: $e');
      // Fallback or handle permission request here if needed
    }

    debugPrint(
      'Auto daily reminder scheduled for $_autoReminderHour:$_autoReminderMinute',
    );
  }

  /// Request notification permissions
  Future<bool> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final isGranted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );

    return isGranted;
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    final notification = message.notification;
    final android = message.notification?.android;

    // Show local notification when app is in foreground
    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Handle when user taps on notification (app in background/terminated)
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Notification opened app: ${message.data}');
    // Handle navigation based on notification data
    _navigateBasedOnPayload(message.data);
  }

  /// Handle local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        _navigateBasedOnPayload(data);
      } catch (e) {
        debugPrint('Error parsing notification payload: $e');
      }
    }
  }

  /// Navigate based on notification payload
  void _navigateBasedOnPayload(Map<String, dynamic> data) {
    // Implement navigation logic based on notification type
    final type = data['type'] as String?;
    switch (type) {
      case 'daily_reminder':
        // Navigate to learning session
        debugPrint('Navigate to learning session');
        break;
      case 'achievement':
        // Navigate to achievements
        debugPrint('Navigate to achievements');
        break;
      case 'streak':
        // Navigate to profile/stats
        debugPrint('Navigate to profile');
        break;
      default:
        // Default: open app home
        debugPrint('Open app home');
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }

  /// Show a local notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    await _localNotifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload != null ? jsonEncode(payload) : null,
    );
  }

  /// Schedule a daily reminder notification (user-configured)
  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    // Cancel any existing user daily reminder
    await cancelDailyReminder();

    // Schedule new user daily reminder
    try {
      await _localNotifications.zonedSchedule(
        id: _userDailyReminderId,
        title: title,
        body: body,
        scheduledDate: _nextInstanceOfTime(hour, minute),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('Error scheduling user daily reminder: $e');
    }

    debugPrint('Daily reminder scheduled for $hour:$minute');
  }

  /// Get the next instance of the specified time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  /// Cancel user-configured daily reminder
  Future<void> cancelDailyReminder() async {
    await _localNotifications.cancel(id: _userDailyReminderId);
    debugPrint('User daily reminder cancelled');
  }

  /// Cancel auto daily reminder
  Future<void> cancelAutoDailyReminder() async {
    await _localNotifications.cancel(id: _autoDailyReminderId);
    debugPrint('Auto daily reminder cancelled');
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    debugPrint('All notifications cancelled');
  }

  // Settings persistence methods

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  /// Set notifications enabled/disabled
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);

    if (!enabled) {
      await cancelAllNotifications();
    } else {
      // Re-schedule auto daily reminder when notifications are re-enabled
      await scheduleAutoDailyReminder();
    }
  }

  /// Check if daily reminder is enabled
  Future<bool> isDailyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dailyReminderEnabledKey) ?? false;
  }

  /// Set daily reminder enabled/disabled
  Future<void> setDailyReminderEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dailyReminderEnabledKey, enabled);

    if (!enabled) {
      await cancelDailyReminder();
    }
  }

  /// Get daily reminder time
  Future<({int hour, int minute})> getDailyReminderTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt(_dailyReminderHourKey) ?? 20; // Default 8 PM
    final minute = prefs.getInt(_dailyReminderMinuteKey) ?? 0;
    return (hour: hour, minute: minute);
  }

  /// Set daily reminder time
  Future<void> setDailyReminderTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_dailyReminderHourKey, hour);
    await prefs.setInt(_dailyReminderMinuteKey, minute);
  }
}
