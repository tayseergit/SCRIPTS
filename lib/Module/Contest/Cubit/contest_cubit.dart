import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Contest/Model/contest_response.dart';
import 'package:lms/generated/l10n.dart';
import 'contest_state.dart';

class ContestCubit extends Cubit<ContestState> {
  ContestCubit() : super(ContestInitial());

  ContestsResponse? contestResponse;

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final searchController = TextEditingController();

  final labels = [
    'ended',
    'active',
    'coming',
  ];
  int selectedTab = 0;

  List<Contest> allContests = [];
   int currentPage = 1;
  bool hasMorePages = true;
  bool isLoading = false;

  List<String> getLabels(BuildContext context) {
    return [
      S.of(context).ended,
      S.of(context).active,
      S.of(context).coming,
    ];
  }
 
  void resetPagination() {
    currentPage = 1;
    hasMorePages = true;
    isLoading = false;
    allContests.clear();
  }
  void changeTab(int index) {
    selectedTab = index;
        resetPagination();

    emit(Selected());
    getContest();
  }

  Future<void> getContest( ) async {
     if (!hasMorePages || isLoading) return;
    isLoading = true;
    if (currentPage == 1) emit(ContestLoading());


    try {
      final response = await DioHelper.getData(
        url: "contests",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'type': 'quiz',
          'status': labels[selectedTab],
          'search': searchController.text.trim(),
          'page': currentPage,
          // 'items': "1"
        },
      );

      if (response.statusCode == 200) {
        contestResponse = ContestsResponse.fromJson(response.data);
 allContests.addAll(contestResponse!.contests);
  final meta = contestResponse!.meta;
          hasMorePages = meta.currentPage < meta.lastPage;
          currentPage = meta.currentPage + 1;
          if (hasMorePages) currentPage++;

        emit(ContestSuccess());
      }
    } on DioException catch (e) {
      emit(ContestError(message: "Connection Error"));
    } finally {
      isLoading = false;
    }
  }
}
