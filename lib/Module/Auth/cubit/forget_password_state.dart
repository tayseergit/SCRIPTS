part of 'forget_password_cubit.dart';

@immutable
class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class SendCodeLoading extends ForgetPasswordState {}

class SendCodeSuccess extends ForgetPasswordState {}

class SendCodeError extends ForgetPasswordState {
  final String message;
  SendCodeError({required this.message});
}

/////
class CheckCodeLoading extends ForgetPasswordState {}

class CheckCodeSuccess extends ForgetPasswordState {}

class CheckCodeError extends ForgetPasswordState {
  final String message;
  CheckCodeError({required this.message});
}

///////
class ResetPasswordLoading extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class ResetPasswordError extends ForgetPasswordState {
  final String message;
  ResetPasswordError({required this.message});
}

class ForgetPasswordErrorConnection extends ForgetPasswordState {
  final String message;
  ForgetPasswordErrorConnection({required this.message});
}

class PasswordError extends ForgetPasswordState {
  final String message;
  PasswordError({required this.message});
}
class Validate extends ForgetPasswordState {}
