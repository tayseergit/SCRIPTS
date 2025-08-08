import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Edit_profile/Cubit/edite_profile_state.dart';
import 'package:lms/Module/Edit_profile/Model/edite_profile_mode;.dart';
import 'package:lms/generated/l10n.dart';
import 'package:path/path.dart' as p;

class EditeProfileCubit extends Cubit<EditeProfileState> {
  EditeProfileCubit() : super(EditeProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String bio,
    required String gitHubAccount,
    required String age,
    File? image,
    required BuildContext context,
  }) async {
    emit(EditeProfileLoading());

    try {
      print("📌 Starting profile update...");

      String? token = CacheHelper.getData(key: "token");
      print("🔑 Token: $token");

      // تجهيز البيانات
      Map<String, dynamic> dataMap = {
        "name": name,
        "bio": bio,
        "gitHub_account": gitHubAccount,
        "age": age,
      };

      if (image != null) {
        dataMap["image"] = await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
          contentType: MediaType(
            "image",
            image.path.split('.').last,
          ),
        );
      }

      print("📤 Data to send: $dataMap");

      FormData formData = FormData.fromMap(dataMap);

      print("🌍 Sending request to: ${Urls.update}");
      print(
          "📦 Headers: {Accept: application/json, Authorization: Bearer $token}");

      // إرسال الطلب
      final response = await DioHelper.postFormData(
        url: Urls.update,
        postData: formData,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // طباعة الرد
      print("📥 Response Status Code: ${response.statusCode}");
      print("📥 Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        print("✅ Update success: Parsing user data...");
        UserResponse updatedUser = UserResponse.fromJson(response.data);

        CacheHelper.saveData(key: "user_name", value: updatedUser.user.name);
        CacheHelper.saveData(key: "user_image", value: updatedUser.user.image);

        print("💾 Saved user_name: ${updatedUser.user.name}");
        print("💾 Saved user_image: ${updatedUser.user.image}");

        emit(EditeProfileSuccess());
      } else {
        print("❌ Server returned error: ${response.data['message']}");
        emit(EditeProfileError(
          message: response.data['message'] ?? S.of(context).error_occurred,
        ));
      }
    } catch (error, stackTrace) {
      print("💥 Exception occurred while updating profile");
      print("❌ Error: $error");
      print("📜 StackTrace: $stackTrace");
      emit(EditeProfileError(message: S.of(context).error_in_server));
    }
  }
}
