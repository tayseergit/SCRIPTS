import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';

abstract class LearnPathInfoState {}

class LearnPathInfoInitial extends LearnPathInfoState {}

class LearnPathInfoLoding extends LearnPathInfoState {}

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
