import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/StudentsProfile/Model/student_profile_model.dart';
import 'package:meta/meta.dart';

part 'student_profile_state.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileInitial());
    static StudentProfileCubit get(BuildContext context) => BlocProvider.of(context);

  StudentProfileModel? studentProfileModel;

  void getProfile() async {
  emit(ProfileLoading());

  try {
    final token = CacheHelper.getData(key: "token");
    final userId = CacheHelper.getData(key: "user_id");

    final response = await DioHelper.getData(
      url: "users/$userId",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      studentProfileModel = StudentProfileModel.fromJson(response.data['user']);
      emit(ProfileSuccess(studentProfileModel!));
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

}
