import 'package:lms/Module/Teacher/Model/teacher_model.dart';

abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherSuccess extends TeacherState {
  final UsersResponse usersResponse;

  TeacherSuccess({required this.usersResponse});
}

class TeacherLoding extends TeacherState {}

class TeacherError extends TeacherState {  
  final String masseg;
  TeacherError({required this.masseg});
}

class TeacherLoadingCards extends TeacherState {}




