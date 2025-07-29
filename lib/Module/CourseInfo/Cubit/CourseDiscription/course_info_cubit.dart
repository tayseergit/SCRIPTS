import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_state.dart';
import 'package:lms/Module/CourseInfo/Model/CourseDiscription/course_discription_response.dart';
import 'package:meta/meta.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CourseInfoCubit extends Cubit<CourseInfoState> {
  CourseInfoCubit({required this.courseId}) : super(CourseInfoInitial());

//tags

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final userimg = CacheHelper.getData(key: "user_img");

  late int courseId;
  CourseDescriptionResponse? courseDescriptionResponse;

  void getCourseDescription() async {
    print(token);
    print(userId);
    emit(CouresDescriptionLoading());

    try {
      final response =
          await DioHelper.getData(url: "courses/$courseId/description", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }, params: {
        "page": "1"
      });
      if (response.statusCode == 200) {
        courseDescriptionResponse =
            CourseDescriptionResponse.fromJson(response.data);
        emit(CouresDescriptionSuccess());
      }
      // else if (response.statusCode == 422){
      //   emit(CouresUnUthunticatedError(message: 'Make Rigister Or Log In '));
      // }
    } on DioException catch (dioError) {
      // if()
      emit(CouresDescriptionError(message: dioError.message ?? 'Dio error'));
    } catch (e) {
      emit(CouresDescriptionError(message: 'Unexpected error occurred'));
    }
  }

  // /////////////

  void postEnrollCourse() async {
    emit(EnrollCouresLoading());
    try {
      final response = await DioHelper.getData(
        // url: "courses/$userId/description",
        url: "courses/$courseId/enroll",

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        courseDescriptionResponse =
            CourseDescriptionResponse.fromJson(value.data);
        emit(CouresDescriptionSuccess());
      }).catchError((error) {
        emit(CouresDescriptionError(message: 'error'));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(CouresDescriptionError(message: 'error'));
    }
  }
}
