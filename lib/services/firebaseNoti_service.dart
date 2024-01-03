// ignore_for_file: file_names

import 'package:ice_chat/services/firebaseAuth_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _logger = Logger();

  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();
      _logger.d('FCMtoken: $fCMToken');
      await saveFCMToken(fCMToken);
    } catch (e) {
      _logger.e('Error initializing notification: $e');
    }
  }

  Future<void> saveFCMToken(String? token) async {
    try {
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
        _logger.d('FCM token saved: $token');
      }
    } catch (e) {
      _logger.e('Error saving FCM token: $e');
    }
  }

  Future<void> updateFCMTokenOnDeviceSwitch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userDocId') ?? '';

      final newFCMToken = await FirebaseMessaging.instance.getToken();
      if (newFCMToken != null) {
        // Update the FCM token in Firestore
        await FirebaseAuthprovideServiceService()
            .updateFCMToken(userId, newFCMToken);
      }
    } catch (e) {
      _logger.e('Error updating FCM token on device switch: $e');
    }
  }
}
