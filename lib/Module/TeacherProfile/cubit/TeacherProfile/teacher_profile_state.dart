import 'package:lms/Module/TeacherProfile/Model/teacher_profile_model.dart';

abstract class TeacherProfileState {}

class TeacherProfileInitial extends TeacherProfileState {}

class TeacherProfileSuccess extends TeacherProfileState {
  final UserModel userModel;

  TeacherProfileSuccess({required this.userModel});
}

class TeacherProfileLoging extends TeacherProfileState {}

class TeacherProfileError extends TeacherProfileState {
  final String masseg;
  TeacherProfileError({required this.masseg});
}
