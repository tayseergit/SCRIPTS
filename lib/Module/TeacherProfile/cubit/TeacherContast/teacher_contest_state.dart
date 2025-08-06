import 'package:lms/Module/TeacherProfile/Model/teacher_contest_model.dart';

abstract class TeacherContestState {}

class TeacherContestInitial extends TeacherContestState {}

class TeacherContestSuccess extends TeacherContestState {
  final TeacherContestModel teacherContestModel;

  TeacherContestSuccess({required this.teacherContestModel});
}

class TeacherContestLoding extends TeacherContestState {}

class TeacherContestError extends TeacherContestState {
  final String masseg;
  TeacherContestError({required this.masseg});
}
