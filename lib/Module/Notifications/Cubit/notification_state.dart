import 'package:lms/Module/Notifications/Model/notification_model.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final NotificationResponse notificationResponse;

  NotificationSuccess({required this.notificationResponse});
}

class NotificationLoding extends NotificationState {}

class NotificationError extends NotificationState {
  final String masseg;
  NotificationError({required this.masseg});
}
