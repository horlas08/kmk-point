import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

import 'api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _defaultChannel = AndroidNotificationChannel(
  'default_channel',
  'General Notifications',
  description: 'General notifications for the app',
  importance: Importance.defaultImportance,
);

/// Background message handler must be a top-level function
/// Public name so it can be registered from `main.dart` as well.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize plugin if needed
  try {
    final android = AndroidNotificationDetails(
      _defaultChannel.id,
      _defaultChannel.name,
      channelDescription: _defaultChannel.description,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final platform = NotificationDetails(android: android);
    final title = message.notification?.title ?? message.data['title'] ?? '';
    final body = message.notification?.body ?? message.data['body'] ?? message.data['message'] ?? '';
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      platform,
    );
  } catch (e) {
    log('Error in background handler: $e');
  }
}

class PushNotificationService extends GetxService {
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  Future<PushNotificationService> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    // Register background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await _configureToken();
    _listenTokenRefresh();
    _listenForegroundMessages();
    return this;
  }

  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(initSettings);

    try {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_defaultChannel);
    } catch (_) {}
  }

  Future<void> _requestPermission() async {
    try {
      final settings = await _fm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      log('FCM permission: ${settings.authorizationStatus}');
    } catch (e) {
      log('FCM permission request error: $e');
    }
  }

  Future<void> _configureToken() async {
    try {
      final token = await _fm.getToken();
      if (token != null && token.isNotEmpty) {
        Hive.box('appData').put('fcmToken', token);
        // update ApiService header
        try {
          final api = Get.find<ApiService>();
          await api.updateFcmToken(token);
        } catch (_) {}
        log('FCM token: $token');
      }
    } catch (e) {
      log('Error getting FCM token: $e');
    }
  }

  void _listenTokenRefresh() {
    _fm.onTokenRefresh.listen((newToken) async {
      try {
        Hive.box('appData').put('fcmToken', newToken);
        final api = Get.find<ApiService>();
        await api.updateFcmToken(newToken);
        log('FCM token refreshed: $newToken');
      } catch (e) {
        log('Error updating refreshed token: $e');
      }
    });
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('FCM onMessage: ${message.messageId} ${message.notification?.title} ${message.notification?.body}');
      // Show a local notification for foreground messages
      _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final title = message.notification?.title ?? message.data['title'] ?? '';
      final body = message.notification?.body ?? message.data['body'] ?? message.data['message'] ?? '';

      final androidDetails = AndroidNotificationDetails(
        _defaultChannel.id,
        _defaultChannel.name,
        channelDescription: _defaultChannel.description,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      );
      final platformDetails = NotificationDetails(android: androidDetails);
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        platformDetails,
      );
    } catch (e) {
      log('Error showing local notification: $e');
    }
  }
}
