import 'package:lms/Module/TeacherProfile/Model/teacher_learnpath_model.dart';

abstract class TeacherLearnpathState {}

class TeacherLearnPathInitial extends TeacherLearnpathState {}

class TeacherLearnPathSuccess extends TeacherLearnpathState {
  final TeacherLearnPath teacherLearnPathModel;

  TeacherLearnPathSuccess({required this.teacherLearnPathModel});
}

class TeacherLearnPathLoding extends TeacherLearnpathState {}

class TeacherLearnPathError extends TeacherLearnpathState {
  final String masseg;
  TeacherLearnPathError({required this.masseg});
}
