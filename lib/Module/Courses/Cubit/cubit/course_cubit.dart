import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Courses/Model/course_model.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  static CourseCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final labels = ['All', 'Enroll', 'Completed', 'Watchlater'];
  int selectedTab = 0;
  CoursesResponse? courseResponse;

  void getAllCourse() async {
    emit(CourseLoading());

    try {
      final response = await DioHelper.getData(
        url: "courses",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(CourseSuccess());
        courseResponse = CoursesResponse.fromJson(response.data);
      }
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
