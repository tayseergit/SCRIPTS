import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/LearnPath/Model/learn_path_reaponse.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'learn_path_state.dart';

class LearnPathCubit extends Cubit<LearnPathState> {
  LearnPathCubit({required this.context}) : super(LearnPathInitial());
  final BuildContext context;

  static LearnPathCubit get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController searchController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final labels = ['All', 'Enroll', 'Watch later'];
  int selectedTab = 0;

  // Pagination variables
  int currentPage = 1;
  bool hasMorePages = true;
  bool isLoading = false;

  LearningPathsResponse? learningPathsResponse;
  List<LearningPath> allLearningPaths = [];

  List<String> getLabels(BuildContext context) {
    return [
      S.of(context).All,
      S.of(context).enroll,
      S.of(context).watchLater,
    ];
  }

  void reset() {
    currentPage = 1;
    hasMorePages = true;
    isLoading = false;
    allLearningPaths.clear();
  }

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    reset();
    getAllLearnPath();
  }

  Future<void> getAllLearnPath() async {
    if (!hasMorePages || isLoading) return;

    isLoading = true;

    if (currentPage == 1) emit(LearnPathLoading());

    try {
      final response = await DioHelper.getData(
        url: "learningPath",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'page': currentPage,
          'orderBy': 'title',
          'status': selectedTab == 1
              ? "enroll"
              : selectedTab == 2
                  ? "watch_later"
                  : "all",
          'search': searchController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        learningPathsResponse = LearningPathsResponse.fromJson(response.data);

        // Append new data
        allLearningPaths.addAll(learningPathsResponse!.data.learningPaths);

        hasMorePages = learningPathsResponse!.data.hasMorePages;
        if (hasMorePages) currentPage++;

        emit(LearnPathSuccess());
      } else {
        emit(LearnPathError(message: S.of(context).error_occurred));
      }
    } on SocketException {
      emit(LearnPathError(message: S.of(context).error_in_server));
    } on DioException catch (e) {
      emit(LearnPathError(
        message: "حدث خطأ في السيرفر: ${e.response?.statusCode ?? ''}",
      ));
    } catch (_) {
      emit(LearnPathError(message: S.of(context).error_in_server));
    } finally {
      isLoading = false;
    }
  }
}
