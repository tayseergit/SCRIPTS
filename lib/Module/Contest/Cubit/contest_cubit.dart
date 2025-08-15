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

  final labels = [ 'ended','active', 'coming',];
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

  Future<void> getContest() async {
    try {
      emit(ContestLoading());
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
          // 'items': '',
          // 'page': '',
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        contestResponse = ContestsResponse.fromJson(response.data);
        emit(ContestSuccess());
      }
      if (response.statusCode == 422) {
        emit(ContestError(message: 'sssss'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(ContestError(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(ContestError(message: "Connection Error"));
      }
    }
  }
}
