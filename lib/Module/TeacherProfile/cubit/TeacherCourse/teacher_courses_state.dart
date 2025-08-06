import 'package:lms/Module/TeacherProfile/Model/teacher_courses_model.dart';

abstract class TeacherCoursesState {}

class TeacherCoursesInitial extends TeacherCoursesState {}

class TeacherCoursesSuccess extends TeacherCoursesState {
  final CourseModel teacherCoursesModel;

  TeacherCoursesSuccess({required this.teacherCoursesModel});
}

class TeacherCoursesLoding extends TeacherCoursesState {}

class TeacherCoursesError extends TeacherCoursesState {
  final String masseg;
  TeacherCoursesError({required this.masseg});
}
