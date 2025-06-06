abstract class AuthState {}

class AuthInitial extends AuthState {}

class ShowPassword extends AuthState {}

class LogInvalidate extends AuthState {}

class LogInLoading extends AuthState {}

class LogInsucess extends AuthState {}

class LogInError extends AuthState {
  final String message;
  LogInError({required this.message});
}

class FalsePasswordFormat extends AuthState {}

class FalsePasswordConfirmationFormat extends AuthState {}

class TruePasswordFormat extends AuthState {}

class TruePasswordconfirmationFormat extends AuthState {}

class CheckInfo extends AuthState {}

class TimeOut extends AuthState {}

class LogInErrorConnection extends AuthState {
  final String message;
  LogInErrorConnection({required this.message});
}

////   log out
class LogOutLoading extends AuthState {}

class LogOutSuccess extends AuthState {}

class LogOutError extends AuthState {
  final String message;
  LogOutError({required this.message});

  @override
  List<Object?> get props => [message];
}

class IsEmail extends AuthState {}

class IsNotEmail extends AuthState {}

// Signup states

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {
  final String message;
  SignUpError({required this.message});
}
