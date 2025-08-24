import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';

abstract class LearnPathInfoState {}

class LearnPathInfoInitial extends LearnPathInfoState {}

class LearnPathInfoLoading extends LearnPathInfoState {}

class LearnPathInfoError extends LearnPathInfoState {
  final String masseg;
  LearnPathInfoError({required this.masseg});
}

class LearnPathAllDataSuccess extends LearnPathInfoState {
  final LearningPathInfoModel info;
  final LearnPathInfoCourseResponse courses;

  LearnPathAllDataSuccess({
    required this.info,
    required this.courses,
  });
}

class UnAuthUser extends LearnPathInfoState {
  final String masseg;
  UnAuthUser({required this.masseg});
}
class UpdateStatusSuccess extends LearnPathInfoState {}
class UpdateEnrollStatusLoading extends LearnPathInfoState {}
class UpdateLaterStatusLoading extends LearnPathInfoState {}
class UpdateStatusError extends LearnPathInfoState {
    final String masseg;
  UpdateStatusError({required this.masseg});
}

class DeleteStatusLoading extends LearnPathInfoState {}
class DeleteStatusSuccess extends LearnPathInfoState {}
class DeleteStatusError extends LearnPathInfoState {
    final String masseg;
  DeleteStatusError({required this.masseg});
}
