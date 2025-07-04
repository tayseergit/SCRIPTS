import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
 import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Courses/Model/course_response.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  static CourseCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final labels = ['All', 'Enroll', 'Completed', 'Watch later'];
  int selectedTab = 0;
  CoursesResponse? courseResponse;

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    getAllCourse();
  }

  void getAllCourse() async {
    emit(CourseLoading());
 
    try {
      final response = await DioHelper.getData(
        url: "courses",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          // 'orderBy': '1',
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
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        courseResponse = CoursesResponse.fromJson(response.data);
        emit(CourseSuccess());
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      emit(
        CourseError(
          message: 'لا يمكن الاتصال بالخادم.\nتحقق من عنوان الـ IP أو المنفذ.',
        ),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(CourseError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(CourseError(message: "Connection Error"));
      }
    }
  }
}
