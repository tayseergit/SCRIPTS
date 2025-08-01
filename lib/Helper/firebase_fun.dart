import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lms/Helper/cach_helper.dart';

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  if (Platform.isIOS) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('iOS permission: ${settings.authorizationStatus}');
  } else if (Platform.isAndroid) {
    print('Handle Android notification permission if SDK >=33');
  }
}


Future<void> getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  CacheHelper.saveData(key: "fcm", value: token);
  print("🔥 FCM Token: $token");
}