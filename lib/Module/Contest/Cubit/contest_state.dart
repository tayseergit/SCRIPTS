
abstract class ContestState {}

/// Starting point (nothing fetched yet)
class ContestInitial extends ContestState {}

/// While the API / repo is fetching data
class ContestLoading extends ContestState {}

/// Data arrived successfully
class ContestSuccess extends ContestState {}

/// Something went wrong
class ContestError extends ContestState {
  final String message;

  ContestError({required this.message});
}

class Selected extends ContestState {}
