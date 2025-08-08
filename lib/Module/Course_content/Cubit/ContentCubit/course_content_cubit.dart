import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Course_content/Model/course_content_response.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:meta/meta.dart';

import 'package:lms/generated/l10n.dart'; // For localization

class CourseContentCubit extends Cubit<CourseContentState> {
  CourseContentCubit({required this.courseId}) : super(CourseContentInitial());
  int courseId;
  CourseContentResponse? courseContentResponse;

  void getCourseContent(BuildContext context) async {
    emit(CourseContentLoading());

    try {
      await DioHelper.getData(
        url: "courses/$courseId/content",
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${CacheHelper.getToken()}", // Make sure 'token' is available
        },
      ).then((value) {
        if (value.statusCode == 200) {
          courseContentResponse = CourseContentResponse.fromJson(value.data);
          emit(CourseContentSuccess());
        } else {
          emit(CourseContentError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        print("DioException: $error");
        emit(CourseContentError(message: S.of(context).error_occurred));
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(CourseContentError(message: S.of(context).error_in_server));
    }
  }
}
