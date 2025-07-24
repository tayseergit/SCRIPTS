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

