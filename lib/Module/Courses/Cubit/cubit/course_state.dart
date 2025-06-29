part of 'course_cubit.dart';

class CourseState {}

class CourseInitial extends CourseState {}

class CourseSuccess extends CourseState {}

class CourseLoading extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError({required this.message});
}
 