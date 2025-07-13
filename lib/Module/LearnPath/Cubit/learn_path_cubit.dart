import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/LearnPath/Model/learn_path_reaponse.dart';
import 'package:meta/meta.dart';

part 'learn_path_state.dart';

class LearnPathCubit extends Cubit<LearnPathState> {
  LearnPathCubit() : super(LearnPathInitial());

  static LearnPathCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final labels = ['All', 'Enroll', 'Watch later'];
  int selectedTab = 0;
  LearningPathsResponse? learningPathsResponse;

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    getAllLearnPath();
  }

  void getAllLearnPath() async {
    emit(LearnPathLoading());

    try {
      final response = await DioHelper.getData(
        url: "learningPath",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'orderBy': 'title',
          // 'direction': '10',
          'status': selectedTab == 1
              ? "enroll"
              : selectedTab == 2
                  ? "watch_later"
                  : "all",
          'search': searchController.text.trim(),
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        learningPathsResponse = LearningPathsResponse.fromJson(response.data);
        emit(LearnPathSuccess());
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(LearnPathError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(LearnPathError(message: "Connection Error"));
      }
    }
  }
}
