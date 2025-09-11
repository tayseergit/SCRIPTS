 
 import 'package:lms/Module/Course_content/Model/ContentModel/course_content_response.dart';

abstract class CourseContentState {}

class CourseContentInitial extends CourseContentState {}

class CourseContentLoading extends CourseContentState {}

 
class CourseContentError extends CourseContentState {
  final String message;
  CourseContentError({required this.message});
}

class CourseContentSuccess extends CourseContentState {
  final CourseContentResponse courseContentResponse;
  CourseContentSuccess(this.courseContentResponse);
}
 

