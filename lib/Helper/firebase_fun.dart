import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:permission_handler/permission_handler.dart';

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
    if (await Permission.notification.isDenied) {
      var status = await Permission.notification.request();
      print('Android notification permission: $status');
    } else {
      print('Android notification permission already granted');
    }
  }
}


Future<void> getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  CacheHelper.saveData(key: "fcm", value: token);
  print("🔥 FCM Token: $token");
}


 
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
}

void setupForegroundMessageListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message in foreground: ${message.notification?.title}');
    // هنا ممكن تضيف كود لعرض إشعار محلي باستخدام flutter_local_notifications
  });
}

void setupOnMessageOpenedAppListener() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('User clicked on notification and opened the app: ${message.data}');
    // هنا تتعامل مع التنقل عند فتح التطبيق من الإشعار
  });
}
