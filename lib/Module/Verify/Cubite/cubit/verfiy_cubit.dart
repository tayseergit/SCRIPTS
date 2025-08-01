import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Auth/Model/user_auth_model.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_state.dart';
import 'package:lms/generated/l10n.dart';
import 'package:page_transition/page_transition.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyCubitInitial());
  static VerifyCubit get(BuildContext context) => BlocProvider.of(context);
  UserAuthModel? userAuthModel;
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

  void sendCode({required BuildContext context,required int registration}) async {
    emit(VerifyLoading());
    try {
      final response = await DioHelper.postData(
        url: "verificationCode/check",
        postData: {
          'email': email,
          'code': otpController.text.trim(),
          'registration': "$registration",
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 ) {
        final responseData = response.data;
        if (registration==1) {
          userAuthModel = UserAuthModel.fromJson(response.data);
        CacheHelper.saveData(key: "token", value: userAuthModel?.token);
        CacheHelper.saveData(key: "role", value: userAuthModel?.role);
        CacheHelper.saveData(key: "user_id", value: userAuthModel?.userId);
          
        }

        emit(VerifySucsses());
      }
       if (response.statusCode == 401) {
          emit(VerifyErrorCode());
        }
        
        else if (response.statusCode == 422) {
          emit(VerifyErrorConnection(message: S.of(context).email_already_exist));
        }
    } on DioException catch (e) {
      // Check if there's a response from the server
      if (e.response?.statusCode == 429) {
        emit(VerifyErrorConnection(message: S.of(context).connection_error));
      } else {
        emit(VerifyErrorConnection(message: S.of(context).connection_error));
      
    }
      }catch (e){
        // No response received (network error, timeout, etc.)
        print("Connection Error: $e");
        emit(VerifyErrorConnection(message: S.of(context).connection_error));
      }
  }
}
