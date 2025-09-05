import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/CourseTest/Model/course_test_question.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'course_test_state.dart';

class CourseTestCubit extends Cubit<CourseTestState> {
  CourseTestCubit({required this.testId, required this.courseId})
      : super(CourseTestInitial());

  final int testId;
  final int courseId;

  CourseTestQuestion? courseTestQuestion;

  int currentIndex = 0;
  Map<String, int> answers = {}; // questionId : answerId
  late String startTime; // test start time

  void getCourseTest(BuildContext context) async {
    emit(TestLoading());
    try {
      await DioHelper.getData(
        url: "courses/$courseId/tests/$testId",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      ).then((response) {
        if (response.statusCode == 200) {
          print("dvvvvvvvv");
          courseTestQuestion = CourseTestQuestion.fromJson(response.data);
          // Record start time when test is loaded
          startTime = DateTime.now().toString().substring(0, 19);

          emit(TestSuccess());
        } else if (response.statusCode == 401) {
          emit(UnAuth());
        } else {
          emit(TestError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        emit(TestError(message: S.of(context).error_occurred));
        debugPrint("DioException: $error");
      });
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      emit(TestError(message: S.of(context).error_in_server));
    }
  }

  void selectAnswer(int questionId, int answerId) {
    answers[questionId.toString()] = answerId;
    emit(TestSuccess());
  }

  bool get hasSelectedAnswerForCurrentQuestion {
    if (courseTestQuestion == null) return false;
    String questionId =
        courseTestQuestion!.test.questions[currentIndex].id.toString();
    return answers.containsKey(questionId);
  }

  void nextQuestion() {
    if (currentIndex < (courseTestQuestion!.test.questions.length - 1)) {
      currentIndex++;
      emit(TestSuccess());
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      emit(TestSuccess());
    }
  }

  void submitTest(BuildContext context) async {
    emit(TestSubmitLoading());

    final data = {
      "start_time": startTime,
      // "start_time": "2025-08-14 7:11:44",
//
      "answers": answers,
    };

    debugPrint("Submitting: $data");

    try {
      await DioHelper.postData(
        url: "courses/$courseId/tests/$testId",
        postData: data,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      ).then((res) {
        print(res.statusCode);

        print("ddddddddddddd");
        print(res.data["message"]);
        if (res.statusCode == 200) {
          debugPrint("Test submitted successfully");
          emit(TestSubmitSuccess(message: res.data['message']));
        } else if (res.statusCode == 400) {
          emit(TestSubmitError(message: res.data['message']));
        } else {
          emit(TestSubmitError(message: res.data['message']));
        }
      }).catchError((error) {
        emit(TestSubmitError(message: S.of(context).error_occurred));
        debugPrint("DioException: $error");
      });
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      emit(TestSubmitError(message: S.of(context).error_in_server));
    }
  }
}
