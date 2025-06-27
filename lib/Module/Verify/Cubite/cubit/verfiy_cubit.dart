import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyCubitInitial());
  static VerifyCubit get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController otpController = TextEditingController();
  String? email;
  bool iscode = false;

  /// validation
  void isCode() {
    if (otpController.text.length < 6) {
      iscode = false;
    } else {
      iscode = true;
    }
  }

  void sendCode(BuildContext context) async {
    emit(VerifyLoading());
    try {
      final response = await DioHelper.postData(
        url: "verificationCode/check",
        postData: {
          'email': email,
          'code': otpController.text.trim(),
          'registration': "1",
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = response.data;
        print("token${responseData['token']}");
        CacheHelper.saveData(key: "token", value: responseData['token']);
        emit(VerifySucsses());
      }
    } on DioException catch (e) {
      // Check if there's a response from the server
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");

        if (e.response?.statusCode == 401) {
          emit(VerifyErrorCode());
        } else if (e.response?.statusCode == 422) {
          emit(VerifyErrorConnection(message: "This user is already verified"));
        }
      } else {
        // No response received (network error, timeout, etc.)
        print("Connection Error: $e");
        emit(VerifyErrorConnection(message: "Connection Error"));
      }
    }
  }
}
