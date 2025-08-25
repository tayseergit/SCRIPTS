import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_state.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/leader_board_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Model/leader_board_for_past_contest_model.dart';

class LeaderBoardCubit extends Cubit<LeaderBoardState> {
  LeaderBoardCubit() : super(LeaderBoardInitial());

  QuizResultModel? _allResult;
  QuizResultModel? _friendsResult;

  Future<void> fetchLeaderBoards(int contestId) async {
    emit(LeaderBoardLoading());

    try {
      await _fetchSingle(contestId, justFriends: false);
      await _fetchSingle(contestId, justFriends: true);

      emit(LeaderBoardSuccess(
        allResult: _allResult,
        friendsResult: _friendsResult,
      ));
    } catch (e) {
      emit(LeaderBoardError(message: e.toString()));
    }
  }

  Future<void> _fetchSingle(int contestId, {required bool justFriends}) async {
    final token = CacheHelper.getData(key: 'token') ?? '';
    if (token.isEmpty) throw Exception("No token");

    final url = Urls.feachLeaderBoard(contestId, justFriends: justFriends);
    final response = await DioHelper.getData(
      url: url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final quiz = QuizResultModel.fromJson(response.data);
      if (justFriends) {
        _friendsResult = quiz;
      } else {
        _allResult = quiz;
      }
    } else {
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }
}
