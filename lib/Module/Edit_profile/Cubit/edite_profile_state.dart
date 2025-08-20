
class EditeProfileState {}

class EditeProfileInitial extends EditeProfileState {}

class EditeProfileSuccess extends EditeProfileState {}

class EditeProfileLoading extends EditeProfileState {}

class EditeProfileError extends EditeProfileState {
  final String message;
  EditeProfileError({required this.message});
}

