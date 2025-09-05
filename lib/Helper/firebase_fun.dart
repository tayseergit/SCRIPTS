import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initLocalNotifications() {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  flutterLocalNotificationsPlugin.initialize(initSettings);
}
void setupForegroundMessageListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final pushEnabled = CacheHelper.getData(key: 'pushNotifications') ?? true;

    if (!pushEnabled) return; // Ignore notifications if disabled

    print('Received message in foreground: ${message.notification?.title}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  });
}
void setupOnMessageOpenedAppListener() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('User clicked on notification and opened the app: ${message.data}');
    // هنا تتعامل مع التنقل عند فتح التطبيق من الإشعار
  });
}
