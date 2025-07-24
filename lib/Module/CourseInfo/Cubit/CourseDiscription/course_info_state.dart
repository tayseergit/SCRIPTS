abstract class CourseInfoState {}

class CourseInfoInitial extends CourseInfoState {}

class CouresDescriptionLoading extends CourseInfoState {}

class CouresDescriptionSuccess extends CourseInfoState {}

class CouresDescriptionError extends CourseInfoState {
  final String message;

  CouresDescriptionError({required this.message});
}

class CouresReviewLoading extends CourseInfoState {}

class CouresReviewSuccess extends CourseInfoState {}

class CouresReviewError extends CourseInfoState {
  final String message;

  CouresReviewError({required this.message});
}

class EnrollCouresLoading extends CourseInfoState {}

class EnrollCouresSuccess extends CourseInfoState {}

class EnrollCouresError extends CourseInfoState {
  final String message;

  EnrollCouresError({required this.message});
}