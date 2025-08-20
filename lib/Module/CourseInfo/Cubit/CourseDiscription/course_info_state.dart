abstract class CourseInfoState {}

class CourseInfoInitial extends CourseInfoState {}

class CouresDescriptionLoading extends CourseInfoState {}

class CouresDescriptionSuccess extends CourseInfoState {
   
}
 

class CouresDescriptionError extends CourseInfoState {
  final String message;

  CouresDescriptionError({required this.message});
}
class CouresUnUthunticatedError extends CourseInfoState {
  final String message;

   CouresUnUthunticatedError({required this.message});
}

class CouresReviewLoading extends CourseInfoState {}

class CouresReviewSuccess extends CourseInfoState {}

class CouresReviewError extends CourseInfoState {
  final String message;

  CouresReviewError({required this.message});
}

class EnrollCouresLoading extends CourseInfoState {}

class EnrollCouresSuccess extends CourseInfoState {
   final String message;

  EnrollCouresSuccess({required this.message});
}

class EnrollCouresError extends CourseInfoState {
  final String message;

  EnrollCouresError({required this.message});
}


// ---- Adding to Watch Later ----
class AddWatchLaterLoading extends CourseInfoState {}

class AddWatchLaterSuccess extends CourseInfoState {}

class AddWatchLaterError extends CourseInfoState {
  final String message;
  AddWatchLaterError({required this.message});
}

// ---- Removing from Watch Later ----
class RemoveWatchLaterLoading extends CourseInfoState {}

class RemoveWatchLaterSuccess extends CourseInfoState {}

class RemoveWatchLaterError extends CourseInfoState {
  final String message;
  RemoveWatchLaterError({required this.message});
}
