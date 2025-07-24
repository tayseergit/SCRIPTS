import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/CourseInfo/Model/Review/review_response.dart';
import 'package:meta/meta.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  TextEditingController addReviewController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  ReviewResponse? reviewResponse;
  bool reviewExpanded = false;

  void toggleExpand() {
    reviewExpanded = !reviewExpanded;
    print(reviewExpanded);
    emit(ToggleReview());
  }

  void getCourseReview() async {
    emit(ReviewLoading());
    try {
      final response = await DioHelper.getData(
        // url: "courses/$userId/description",
        url: "courses/12/reviews",

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        reviewResponse = ReviewResponse.fromJson(value.data);
        emit(ReviewSuccess());
      }).catchError((error) {
        emit(ReviewError(message: 'error'));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(ReviewError(message: 'error'));
    }
  }

  ///
}
