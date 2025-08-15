part of 'contest_test_cubit.dart';

abstract class ContsetTestState {}

class CourseTestInitial extends ContsetTestState {}

class TestLoading extends ContsetTestState {}

class TestSuccess extends ContsetTestState {}

class TestError extends ContsetTestState {
  final String message;
  TestError({required this.message});
}

class TestSubmitLoading extends ContsetTestState {}

class TestSubmitSuccess extends ContsetTestState {
  final String message;
  TestSubmitSuccess({required this.message});
}

class TestSubmitError extends ContsetTestState {
  final String message;
  TestSubmitError({required this.message});
}
