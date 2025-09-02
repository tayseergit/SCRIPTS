import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_state.dart';
import 'package:lms/Module/CourseInfo/Model/CourseDiscription/course_discription_response.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CourseInfoCubit extends Cubit<CourseInfoState> {
  CourseInfoCubit({required this.courseId, required this.context})
      : super(CourseInfoInitial());
  BuildContext context;
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
      final response = await DioHelper.getData(
          url: "courses/$courseId/description",
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          params: {
            "page": "1"
          }).then((value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          courseDescriptionResponse =
              CourseDescriptionResponse.fromJson(value.data);
          emit(CouresDescriptionSuccess());
        } else if (value.statusCode == 422) {
          emit(CouresUnUthunticatedError(message: 'Make Rigister Or Log In '));
          CacheHelper.removeData(key: "token");
          // CacheHelper.removeData(key: key);
        }
        print(value.data['message']);
      }).catchError((e) {
        emit(CouresDescriptionError(message: S.of(context).error_occurred));
      });
    } catch (e) {
      emit(CouresDescriptionError(message: S.of(context).error_in_server));
    }
  }

  // /////////////

  void postEnrollCourse(int courseId) async {
    emit(EnrollCouresLoading());
    try {
      final response = await DioHelper.postData(
        // url: "courses/$userId/description",
        url: "courses/$courseId/enroll",

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value.data['message']);
        print(value.statusCode);

        if (value.statusCode == 200) {
          courseDescriptionResponse!.data.status = "enroll";
          courseDescriptionResponse!.data.studentPaid =
              courseDescriptionResponse!.data.price;
          getCourseDescription();
          emit(EnrollCouresSuccess(message: value.data['message']));
        } else if (value.statusCode == 401) {
          emit(CouresUnUthunticatedError(
              message: S.of(context).Login_or_SignUp));
        } else {
          emit(EnrollCouresError(message: value.data['message']));
          print(value.data['message']);
        }
      }).catchError((error) {
        emit(EnrollCouresError(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(EnrollCouresError(message: S.of(context).error_in_server));
    }
  }

  //// watch later

  void addWatchLater() async {
    emit(AddWatchLaterLoading());
    try {
      final response = await DioHelper.postData(
        // url: "courses/$userId/description",
        url: "courses/$courseId/watch_later",

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value.data['message']);
        print("sdsdsdsdsdsd");
        print(courseId);
        print(value.statusCode);

        if (value.statusCode == 200) {
          getCourseDescription();

          emit(AddWatchLaterSuccess());
        } else if (value.statusCode == 401) {
          emit(CouresUnUthunticatedError(
              message: S.of(context).Login_or_SignUp));
        } else {
          emit(AddWatchLaterError(message: value.data['message']));
          print(value.data['message']);
        }
      }).catchError((error) {
        emit(AddWatchLaterError(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(AddWatchLaterError(message: S.of(context).error_in_server));
    }
  }

  // removing watch later

  void removeWatchLater() async {
    emit(RemoveWatchLaterLoading());
    try {
      final response = await DioHelper.deleteData(
        // url: "courses/$userId/description",
        url: "courses/$courseId/watch_later",

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value.data['message']);
        print(value.statusCode);

        if (value.statusCode == 200) {
          emit(RemoveWatchLaterSuccess());
          getCourseDescription();
        } else if (value.statusCode == 401) {
          emit(CouresUnUthunticatedError(
              message: S.of(context).Login_or_SignUp));
        } else {
          emit(RemoveWatchLaterError(message: value.data['message']));
          print(value.data['message']);
        }
      }).catchError((error) {
        emit(RemoveWatchLaterError(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(RemoveWatchLaterError(message: S.of(context).error_in_server));
    }
  }
}
