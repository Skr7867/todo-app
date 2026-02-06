import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../view_models/controller/user_preferences/user_preferences_viewmodel.dart';
import 'fcm_repository.dart';

class FCMManager {
  static final _fcm = FirebaseMessaging.instance;
  static final _repo = FCMRepository();
  static final _userPref = UserPreferencesViewmodel();

  static Future init() async {
    /// Permission
    await _fcm.requestPermission();

    /// Register Current Token
    await _registerToken();

    /// Token Refresh Listener ⭐ IMPORTANT
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("🔄 FCM Token Refreshed => $newToken");
      await _sendTokenToBackend(newToken);
    });

    /// Foreground Listener
    FirebaseMessaging.onMessage.listen((message) {
      log("📩 Foreground FCM => ${message.notification?.title}");
    });

    /// Notification Click
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("👆 Notification Clicked");
    });
  }

  /// =============================
  /// REGISTER TOKEN
  /// =============================
  static Future _registerToken() async {
    try {
      final token = await _fcm.getToken();

      if (token == null) return;

      log("🔥 FCM TOKEN => $token");

      await _sendTokenToBackend(token);
    } catch (e) {
      log("FCM Register Error => $e");
    }
  }

  /// =============================
  /// SEND TOKEN TO BACKEND
  /// =============================
  static Future _sendTokenToBackend(String token) async {
    final user = await _userPref.getUser();
    final authToken = user.token;

    if (authToken == null || authToken.isEmpty) {
      log("⚠ User not logged in, skipping FCM register");
      return;
    }

    await _repo.registerToken(fcmToken: token, authToken: authToken);
  }
}
