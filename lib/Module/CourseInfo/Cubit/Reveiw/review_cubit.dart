import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/CourseInfo/Model/Review/add_review_response.dart';
import 'package:lms/Module/CourseInfo/Model/Review/review_response.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({required this.courseId,required this .context}) : super(ReviewInitial());
  BuildContext context;
  TextEditingController addReviewController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final userimg = CacheHelper.getData(key: "user_img");
  int courseId;
  ReviewResponse? reviewResponse;
  AddReviewResponse? addReviewResponse;
  bool reviewExpanded = false;
  double? userRating;

  int currentPage = 1;
  bool hasMorePages = true;
  bool HasYourReview = false;
  bool isLoading = false;
  List<Review> allReviews = [];

  void toggleExpand() {
    reviewExpanded = !reviewExpanded;
    print(reviewExpanded);
    emit(ToggleReview());
  }

  void reset() {
    currentPage = 1;
    hasMorePages = true;
    HasYourReview = false;
    addReviewController.text = "";
    allReviews.clear();
  }

  Future<void> getCourseReview({bool isInitial = false}) async {
    print(hasMorePages);
    if (!hasMorePages) return;

    emit(ReviewLoading());

    try {
      final response = await DioHelper.getData(
        url: "courses/$courseId/reviews",
        params: {"page": currentPage},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          final newReviews = ReviewResponse.fromJson(response.data);
          hasMorePages = newReviews.data.hasMorePages;

          if (hasMorePages) currentPage++;
          if (newReviews.data.reviews.isNotEmpty) {
            allReviews.addAll(newReviews.data.reviews);
          }
          if (allReviews.isNotEmpty && allReviews[0].yourReview) {
            HasYourReview = true;
          } else {
            HasYourReview = false;
          }

          emit(ReviewSuccess());
        } else {
          emit(ReviewError(message: response.data['message']));
        }
      }).catchError((response) {
        emit(ReviewError(message: S.of(context).error_occurred));
      });
    } catch (e) {
      print(e.toString());
      print("xxxxxxxxxxx");
      emit(ReviewError(message: S.of(context).error_in_server));
    }
  }

  /////
  ///
  Future<void> postCourseReview() async {
    print(userRating);
    if (addReviewController.text.isEmpty ||
        userRating == 0 ||
        userRating == null) {
      emit(AddReviewRequired(message: "Field and rating are required"));
      return;
    }

    emit(AddReviewLoading());

    try {
      final response = await DioHelper.postData(
        url: "courses/$courseId/reviews",
        postData: {
          "comment": addReviewController.text.trim(),
          "rate": (userRating ?? 0.0).toInt()
        },
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        if (response.statusCode == 200) {
          // final addReviewResponse = AddReviewResponse.fromJson(response.data);
          emit(AddReviewSuccess());
          reset();
          getCourseReview();
        } else if (response.statusCode == 401) {
          emit(AddReviewError(message: 'Login or signup'));
        } else {
          print(response.statusCode);
        }
      }).catchError((response) {
        emit(AddReviewError(message: 'Unexpected error occurred'));
      });
    } catch (e) {
      print(e.toString());
      emit(AddReviewError(message: 'error in server'));
    }
  }

  ///////////
  Future<void> editCourseReview() async {
    emit(AddReviewLoading());

    try {
      final response = await DioHelper.putData(
        url: "courses/$courseId/reviews",
        putData: {
          "comment": addReviewController.text.trim(),
          "rate": (userRating ?? 0.0).toInt(),
        },
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // ✅ Ensure the server accepted the update
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddReviewSuccess());
        reset();

        // ✅ Only after the above finishes, call getCourseReview()
        await getCourseReview();
      } else {
        emit(AddReviewError(message: "Failed to update review"));
      }
    } catch (e) {
      emit(AddReviewError(message: "Error"));
    }
  }

  ////
  Future<void> deleteCourseReview() async {
    emit(DeleteReviewLoading());

    try {
      final response = await DioHelper.deleteData(
        url: "courses/$courseId/reviews",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      emit(DeleteReviewSuccess());
      reset();
      getCourseReview();
    } on DioException {
      emit(DeleteReviewError(message: 'Error deleting'));
    } catch (e) {
      print(e.toString());
      emit(DeleteReviewError(message: 'Unexpected error occurred'));
    }
  }
}
