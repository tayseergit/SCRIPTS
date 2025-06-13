import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  // LOGIN
  TextEditingController emailCtrl = TextEditingController(
    text: "eng.tayseermatar@gmail.com",
  );
  TextEditingController passWordctrl = TextEditingController(
    text: "1234/*-+As",
  );

  TextEditingController confirmPassWordctrl = TextEditingController(
    text: "1234/*-+Asa",
  );

  final TextEditingController code = TextEditingController();

  bool obscuretext = true;
  bool isEmail = true;
  bool isPassWord = true;
  bool isPassWordconf = true;
  bool isActive = false;

//////////////   validation
  ///

  void validEmail(String email) {
    if (GlobalFunc.validEmail(email)) {
      isEmail = true;
      emit(IsEmail());
    } else {
      isEmail = false;
      emit(IsNotEmail());
    }
  }

  void passwordValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit(IsPassword());
      isPassWord = false;
    } else {
      emit(IsNotPassword());
      isPassWord = true;
    }
    if (passWordctrl.text.isEmpty ||
        confirmPassWordctrl.text.isEmpty ||
        passWordctrl.text != confirmPassWordctrl.text) {
      isActive = false;
    } else {
      isActive = true;
      emit(ActiveButton());
    }
  }

  void passwordConfValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit((IsPasswordconf()));
      isPassWordconf = false;
    } else {
      emit(IsNotPasswordcon());
      isPassWordconf = true;
    }
    if (passWordctrl.text.isEmpty ||
        confirmPassWordctrl.text.isEmpty ||
        passWordctrl.text != confirmPassWordctrl.text) {
      isActive = false;
    } else {
      isActive = true;
      emit(ActiveButton());
    }
  }

////////////  login
  ///
  void sendEmail() async {
    if (emailCtrl.text.isEmpty) {
      emit(IsNotEmail());
    } else {
      emit(SendEmailLoading());

      try {
        final response = await DioHelper.postData(
          url: "verificationCode/send",
          postData: {
            'email': emailCtrl.text,
            'registration': "0",
          },
          headers: {"Accept": "application/json"},
        );

        print("Status Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          final responseData = response.data;
          emit(SendEmailSuccess());
        }
      } on DioException catch (e) {
        // Check if there's a response from the server
        if (e.response?.statusCode == 422) {
          emit(SendEmailError(
              message: "This email is not registered,verified."));
        } else {
          // No response received (network error, timeout, etc.)
          print("Connection Error: $e");
          emit(SendEmailError(message: "Connection Error"));
        }
      }
    }
  }

  void resetPassword() async {
    print("fdfdfdfdfd");
    print(emailCtrl.text);
    print(code.text);
    print(passWordctrl.text);
    print(confirmPassWordctrl.text);
    print(confirmPassWordctrl.text);
    print(confirmPassWordctrl.text);
    emit(ResetPasswordLoading());
    print("");
    try {
      final response = await DioHelper.postData(
        url: "password/forget",
        postData: {
          "email": emailCtrl.text.trim(),
          "code": code.text.trim(),
          "password": passWordctrl.text.trim(),
          "password_confirmation": confirmPassWordctrl.text.trim()
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = response.data;
        emit(ResetPasswordSuccess());
        CacheHelper.saveData(key: "token", value: responseData['token']);
      }
    } on DioException catch (e) {
      // Check if there's a response from the server
      if (e.response?.statusCode == 422) {
        emit(ResetPasswordError(
            message: "This email is not registered,verified."));
      } else {
        // No response received (network error, timeout, etc.)
        print("Connection Error: $e");
        emit(ResetPasswordError(message: "Connection Error"));
      }
    }
  }
}
