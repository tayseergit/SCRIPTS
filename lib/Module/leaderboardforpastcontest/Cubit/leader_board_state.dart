import 'package:lms/Module/Teacher/Model/teacher_model.dart';
import 'package:lms/Module/leaderboardforpastcontest/Model/leader_board_for_past_contest_model.dart';

abstract class LeaderBoardState {}

class LeaderBoardInitial extends LeaderBoardState {}

class LeaderBoardLoading extends LeaderBoardState {}

class LeaderBoardError extends LeaderBoardState {
  final String message;
  LeaderBoardError({required this.message});
}

class LeaderBoardSuccess extends LeaderBoardState {
  final QuizResultModel? allResult;
  final QuizResultModel? friendsResult;
  LeaderBoardSuccess({this.allResult, this.friendsResult});
}
