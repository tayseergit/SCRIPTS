part of 'forget_password_cubit.dart';

@immutable
  class ForgetPasswordState {}

  class ForgetPasswordInitial extends ForgetPasswordState {}
  class SendCodeLoading extends ForgetPasswordState {}
  class CheckCodeLoading extends ForgetPasswordState {}
  class ResetPasswordLoading extends ForgetPasswordState {}
   class SendCodeError extends ForgetPasswordState {}
  class CheckCodeError extends ForgetPasswordState {}
  class ResetPasswordError extends ForgetPasswordState {}

    class SendCodeSuccess extends ForgetPasswordState {}
  class CheckCodeSuccess extends ForgetPasswordState {}
  class ResetPasswordSuccess extends ForgetPasswordState {}