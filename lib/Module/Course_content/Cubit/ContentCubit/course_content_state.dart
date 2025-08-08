 
 abstract class CourseContentState {}

class CourseContentInitial extends CourseContentState {}

class CourseContentLoading extends CourseContentState {}

class CourseContentSuccess extends CourseContentState {}

class CourseContentError extends CourseContentState {
  final String message;
  CourseContentError({required this.message});
}
