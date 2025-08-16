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

  List<String> getLabels(BuildContext context) {
    return [
      S.of(context).ended,
      S.of(context).active,
      S.of(context).coming,
    ];
  }

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    getContest();
  }

  List<Contest> allContests = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;

  Future<void> getContest({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || currentPage >= lastPage) return;
      isLoadingMore = true;
      emit(ContestLoadingMore());
    } else {
      currentPage = 1;
      allContests.clear();
      emit(ContestLoading());
    }

    try {
      final response = await DioHelper.getData(
        url: "contests",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'type': 'all',
          'status': labels[selectedTab],
          'search': searchController.text.trim(),
          'page': currentPage,
          // 'items': "1"
        },
      );

      if (response.statusCode == 200) {
        contestResponse = ContestsResponse.fromJson(response.data);

        // Update meta info
        currentPage = contestResponse!.meta.currentPage;
        lastPage = contestResponse!.meta.lastPage;

        // Append results
        allContests.addAll(contestResponse!.contests);

        emit(ContestSuccess());
      }
    } on DioException catch (e) {
      emit(ContestError(message: "Connection Error"));
    } finally {
      isLoadingMore = false;
    }
  }
}
