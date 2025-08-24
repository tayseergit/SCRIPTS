import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Courses/Model/course_response.dart';
import 'package:lms/generated/l10n.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({required this.context}) : super(CourseInitial());
  BuildContext context;
  TextEditingController searchController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final labels = ['All', 'Enroll', 'Completed', 'Watch later'];
  int selectedTab = 0;
  bool isLoading = false;
  List<Course> allCourses = [];

  int currentPage = 1;
  bool hasMorePages = true;
  CoursesResponse? courseResponse;

  List<String> getLabels(BuildContext context) {
    return [
      S.of(context).All,
      S.of(context).enroll,
      S.of(context).Completed,
      S.of(context).watchLater,
    ];
  }

  void reset() {
    currentPage = 1;
    hasMorePages = true;

    allCourses.clear();
  }

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    reset();
    getAllCourse();
  }

  void getAllCourse() async {
    if (!hasMorePages || isLoading) return;

    isLoading = true; // Mark as loading

    if (currentPage == 1) {
      print("dddddddd");
      emit(CourseLoading());
    }

    try {
      final response = await DioHelper.getData(
        url: "courses",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'page': currentPage,
          // 'direction': '10',
          'status': selectedTab == 1
              ? "enrolled"
              : selectedTab == 2
                  ? "finished"
                  : selectedTab == 3
                      ? "watch_later"
                      : "all",
          'search': searchController.text.trim(),
        },
      ).then((response) {
        if (response.statusCode == 200) {
          courseResponse = CoursesResponse.fromJson(response.data);
          hasMorePages = courseResponse!.data.hasMorePages;
          allCourses.addAll(courseResponse!.data.courses);
          if (hasMorePages) currentPage++;
          emit(CourseSuccess());
        }
      }).catchError((value) {
        emit(CourseError(message: S.of(context).error_occurred));
      });
    } catch (e) {
      emit(CourseError(message: S.of(context).error_in_server));
    } finally {
      isLoading = false;
    }
  }
}
/** on SocketException catch (e) {
      debugPrint('SocketException: $e');
      emit(
        CourseError(
          message: S.of(context).error_in_server,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(CourseError(message: S.of(context).error_in_server));
      } else if (e.response != null) {
        emit(CourseError(
            message: "حدث خطأ في السيرفر: ${e.response?.statusCode}"));
      } else {
        emit(CourseError(message: S.of(context).error_in_server));
      }
    } */
