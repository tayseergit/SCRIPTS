import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/ContestTest/Model/contest_test_question.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'contest_test_state.dart';

class ContestTestCubit extends Cubit<ContsetTestState> {
  ContestTestCubit({required this.contestId}) : super(CourseTestInitial());

  final int contestId;
  int? remainingSeconds;
  ContestQuestionResponse? contestTestQuestion;

  int currentIndex = 0;
  Map<String, int> answers = {}; // questionId : answerId
  late String startTime; // test start time

  void getContestTest(BuildContext context) async {
    emit(TestLoading());
    try {
      final response = await DioHelper.getData(
        url: "contests/$contestId/questions",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      ).then((value) {
        print(value.statusCode);
 
        if (value.statusCode == 200) {
          contestTestQuestion = ContestQuestionResponse.fromJson(value.data);

          remainingSeconds = contestTestQuestion!.minutesLeft.toInt()*60;

          emit(TestSuccess());
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
    if (contestTestQuestion == null) return false;
    String questionId =
        contestTestQuestion!.questions[currentIndex].id.toString();
    return answers.containsKey(questionId);
  }

  void nextQuestion() {
    if (currentIndex < (contestTestQuestion!.questions.length - 1)) {
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
      "answers": answers,
    };

    debugPrint("Submitting: $data");

    try {
      await DioHelper.postData(
        url: "contests/$contestId/questions",
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
