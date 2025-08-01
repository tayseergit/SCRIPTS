import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  TextEditingController emailctrl = TextEditingController();
  final TextEditingController passwordctrl = TextEditingController(
    text: "1234/*-+Asa",
  );
  final TextEditingController confirmPasswordCtrl = TextEditingController(
    text: "1234/*-+Asa",
  );
  final TextEditingController otpController = TextEditingController();

  bool obscuretext = true;
  bool isEmail = true, showIsNotEmail = false;
  bool isPassWord = true;
  bool isPassWordconf = true;

  void validEmail(String email) {
    if (GlobalFunc.validEmail(email)) {
      isEmail = true;
      showIsNotEmail = false;
    } else {
      isEmail = false;
      showIsNotEmail = true;
    }
  }

  void passwordValid({required String password}) {
    if (!GlobalFunc.passwordValid(password: password)) {
      isPassWord = false;
    } else {
      isPassWord = true;
    }
  }

  void passwordConfValid({required String password}) {
    if (!GlobalFunc.passwordValid(password: password)) {
      isPassWordconf = false;
    } else {
      isPassWordconf = true;
    }
  }

  void sendCode(BuildContext context) async {
    if (!isEmail) return;
    emit(SendCodeLoading());
    try {
      final response = await DioHelper.postData(
        url: "verificationCode/send",
        postData: {
          'email': emailctrl.text.trim(),
          'registration': "0",
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(SendCodeSuccess());
      } else if (response.statusCode == 422) {
        emit(SendCodeError(message: S.of(context).Email_not_found));
      } else if (response.statusCode == 429) {
        emit(SendCodeError(message: S.of(context).error_in_server));
      } else {
        emit(SendCodeError(message: S.of(context).connection_error));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        if (e.response?.statusCode == 429) {
          emit(SendCodeError(message: S.of(context).error_in_server));
        } else {
          emit(SendCodeError(message: S.of(context).connection_error));
        }
      } else {
        print("Connection Error: $e");
        emit(ForgetPasswordErrorConnection(message: S.of(context).connection_error));
      }
    } catch (e) {
      emit(ForgetPasswordErrorConnection(message: S.of(context).connection_error));
    }
  }

  void resetPassword(BuildContext context) async {
    if (passwordctrl.text.trim() != confirmPasswordCtrl.text.trim()) {
      emit(PasswordError(message: S.of(context).passwords_do_not_match));
      return;
    }
    emit(ResetPasswordLoading());
    try {
      final response = await DioHelper.postData(
        url: "password/forget",
        postData: {
          'email': emailctrl.text.trim(),
          'code': otpController.text,
          'password': passwordctrl.text.trim(),
          'password_confirmation': confirmPasswordCtrl.text.trim(),
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(ResetPasswordSuccess());
      } else if (response.statusCode == 422) {
        emit(ResetPasswordError(message: S.of(context).connection_error));
      } else if (response.statusCode == 429) {
        emit(ResetPasswordError(message: S.of(context).connection_error));
      } else {
        emit(ResetPasswordError(message: S.of(context).connection_error));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        if (e.response?.statusCode == 429) {
          emit(ResetPasswordError(message: S.of(context).connection_error));
        } else {
          emit(ResetPasswordError(message: S.of(context).an_error_occurred));
        }
      } else {
        print("Connection Error: $e");
        emit(ForgetPasswordErrorConnection(message: S.of(context).connection_error));
      }
    } catch (e) {
      emit(ForgetPasswordErrorConnection(message: S.of(context).connection_error));
    }
  }
}
