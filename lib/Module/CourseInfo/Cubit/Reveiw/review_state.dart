part of 'review_cubit.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ToggleReview extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {}

class ReviewError extends ReviewState {
  final String message;

  ReviewError({required this.message});
}

class AddReviewLoading extends ReviewState {}

class AddReviewSuccess extends ReviewState {}

class AddReviewError extends ReviewState {
  final String message;

  AddReviewError({required this.message});
}

class AddReviewRequired extends ReviewState {
  final String message;

  AddReviewRequired({required this.message});
}


class DeleteReviewLoading extends ReviewState {}

class DeleteReviewSuccess extends ReviewState {}

class DeleteReviewError extends ReviewState {
  final String message;

  DeleteReviewError({required this.message});
}
