import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';

class NotificationSwitchPushNotificationsCubit extends Cubit<bool> {
  NotificationSwitchPushNotificationsCubit() : super(false);

  void toggleSwitch(bool value) {
    emit(value);
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
