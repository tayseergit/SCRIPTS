import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationSwitchPushNotificationsCubit extends Cubit<bool> {
  NotificationSwitchPushNotificationsCubit() : super(false) {
    _loadInitialState();
  }

  void _loadInitialState() async {
    final savedValue = CacheHelper.getData(key: 'pushNotifications');
    if (savedValue == null) {
      emit(true);
      await CacheHelper.saveData(key: 'pushNotifications', value: true);
      _enableNotifications();
    } else {
      emit(savedValue);
      if (savedValue) {
        _enableNotifications();
      } else {
        _disableNotifications();
      }
    }
  }

  void toggleSwitch(bool value) async {
    emit(value);
    await CacheHelper.saveData(key: 'pushNotifications', value: value);
    if (value) {
      _enableNotifications();
    } else {
      _disableNotifications();
    }
  }

  void _enableNotifications() async {
    // Request permission on iOS
    await FirebaseMessaging.instance.requestPermission();
    // Subscribe to topic
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  void _disableNotifications() async {
    // Unsubscribe from topic
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
  }
}

class NotificationSwitchDarkModeCubit extends Cubit<bool> {
  NotificationSwitchDarkModeCubit() : super(_getInitialSwitch());

  static bool _getInitialSwitch() {
    final isLight = CacheHelper.getData(key: "lightMode");
    if (isLight == null) return true; // الوضع الافتراضي Dark
    return !isLight; // true إذا كان LightMode
  }

  void toggleSwitch(bool value) => emit(value);
}
