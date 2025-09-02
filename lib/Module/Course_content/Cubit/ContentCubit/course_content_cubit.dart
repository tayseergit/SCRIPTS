import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:lms/Module/Course_content/Model/ContentModel/course_content_response.dart';
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
          emit(CourseContentSuccess(courseContentResponse!));
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

  void emitUpdatedContents(List<ContentItem> updatedContents) {
    courseContentResponse!.data!.allContents = updatedContents;
    emit(CourseContentSuccess(courseContentResponse!));
  }

  void markVideoAsCompleted(int videoId) {
    if (courseContentResponse != null) {
      final updatedContents =
          courseContentResponse!.data!.allContents.map((item) {
        if (item.id == videoId) {
          // Update the property directly
          item.watched = true; // or item.completed = true;
        }
        return item; // return the whole item, not just a boolean
      }).toList();

      courseContentResponse!.data!.allContents = updatedContents;
      emit(CourseContentSuccess(courseContentResponse!));
    }
  }

  void markTestAsCompleted(int testId) {
    if (courseContentResponse != null) {
      final updatedContents =
          courseContentResponse!.data!.allContents.map((item) {
        if (item.id == testId) {
          item.completed = true; // mark as completed
        }
        return item;
      }).toList();

      courseContentResponse!.data!.allContents = updatedContents;
      emit(CourseContentSuccess(courseContentResponse!));
    }
  }
}
