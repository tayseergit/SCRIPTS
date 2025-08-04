import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';

class NotificationSwitchPushNotificationsCubit extends Cubit<bool> {
  NotificationSwitchPushNotificationsCubit() : super(false);

  void toggleSwitch(bool value) {
    emit(value);
  }
}

class NotificationSwitchDarkModeCubit extends Cubit<bool> {
  NotificationSwitchDarkModeCubit()
      : super(false);

  void toggleSwitch(bool value) {
    emit(value);
    CacheHelper.saveData(key: "lightMode", value: value);
    print(CacheHelper.getData(key: "lightMode"));
  }
}
