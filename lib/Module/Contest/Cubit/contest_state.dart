import 'package:equatable/equatable.dart';
 
abstract class ContestState extends Equatable {
  @override
  List<Object?> get props => [];
}

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
