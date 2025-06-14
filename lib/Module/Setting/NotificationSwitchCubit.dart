import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSwitchPushNotificationsCubit extends Cubit<bool> {
  NotificationSwitchPushNotificationsCubit() : super(true); 

  void toggleSwitch(bool value) => emit(value);
}
class NotificationSwitchDarkModeCubit extends Cubit<bool> {
  NotificationSwitchDarkModeCubit() : super(true); 

  void toggleSwitch(bool value) => emit(value);
}
