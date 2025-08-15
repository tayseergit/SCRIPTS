part of 'course_test_cubit.dart';

abstract class CourseTestState {}

class CourseTestInitial extends CourseTestState {}

class TestLoading extends CourseTestState {}

class TestSuccess extends CourseTestState {}

class TestError extends CourseTestState {
  final String message;
  TestError({required this.message});
}
class TestSubmitLoading extends CourseTestState {}
class TestSubmitSuccess extends CourseTestState {
    final String message;
  TestSubmitSuccess({required this.message});
}
class TestSubmitError extends CourseTestState {
    final String message;
  TestSubmitError({required this.message});
}
