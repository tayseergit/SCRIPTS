part of 'learn_path_cubit.dart';

class LearnPathState {}

class LearnPathInitial extends LearnPathState {}

class LearnPathSuccess extends LearnPathState {}

class LearnPathLoading extends LearnPathState {}

class LearnPathError extends LearnPathState {
  final String message;
  LearnPathError({required this.message});
}

class Selected extends LearnPathState {}
