import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/StudentsProfile/Model/achievement_response.dart';
import 'package:lms/Module/StudentsProfile/Model/contest_model.dart';
import 'package:lms/Module/StudentsProfile/Model/student_profile_model.dart';
import 'package:meta/meta.dart';

part 'student_profile_state.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileInitial());
  static StudentProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  late StudentProfileModel studentProfileModel;
  CertificateResponse? certificateResponse;
  ContestResponse? contestResponse;
  late AchievementResponse achievementResponse;
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final labels = ['Certificates', 'Achievement', 'My Contest', 'statices'];

  int selectedTab = 0;

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
  }

////////
  void getProfile() async {
    print("sssssssssssss");
    print(userId);
    emit(ProfileLoading());
    try {
      final response = await DioHelper.getData(
        url: "users/$userId",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        studentProfileModel =
            StudentProfileModel.fromJson(response.data['user']);
        if (studentProfileModel.image != null) {
          CacheHelper.saveData(
              key: "user_img", value: studentProfileModel.image);
        }
        emit(ProfileSuccess(studentProfileModel));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(ProfileError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(ProfileError(message: "Connection Error"));
      }
    }
  }

/////////////
///////////
//////////
  ///
  ///
  void getCirtificate() async {
    emit(CertificatesLoading());

    try {
      final response = await DioHelper.getData(
        url: "users/$userId/certificates",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(CertificatesSuccess());
        certificateResponse = CertificateResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(CertificatesError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(CertificatesError(message: "Connection Error"));
      }
    }
  }

////

  void getAchievement() async {
    emit(AchievementLoading());

    try {
      final response = await DioHelper.getData(
        url: "users/$userId/achievements",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(AchievementSuccess());
        achievementResponse = AchievementResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(AchievementError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(AchievementError(message: "Connection Error"));
      }
    }
  }

  void getMyContest() async {
    emit(ContestLoading());

    try {
      final response = await DioHelper.getData(
        url: "users/$userId/contests",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(ContestSuccess());
        contestResponse = ContestResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(ContestError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(ContestError(message: "Connection Error"));
      }
    }
  }
}
