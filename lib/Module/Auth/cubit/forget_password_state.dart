part of 'forget_password_cubit.dart';

 class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class SendEmailLoading extends ForgetPasswordState {}

class CheckCodeLoading extends ForgetPasswordState {}

class ResetPasswordLoading extends ForgetPasswordState {}

class SendEmailError extends ForgetPasswordState {
  final String message;
  SendEmailError({required this.message});
}

class CheckCodeError extends ForgetPasswordState {
  final String message;
  CheckCodeError({required this.message});
}

class ResetPasswordError extends ForgetPasswordState {
  final String message;
  ResetPasswordError({required this.message});
}

class SendEmailSuccess extends ForgetPasswordState {}

class CheckEmailSuccess extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class IsEmail extends ForgetPasswordState {}

class IsNotEmail extends ForgetPasswordState {}

class IsPassword extends ForgetPasswordState {}

class IsNotPassword extends ForgetPasswordState {}

class IsPasswordconf extends ForgetPasswordState {}

class IsNotPasswordcon extends ForgetPasswordState {}

class ActiveButton extends ForgetPasswordState {}
