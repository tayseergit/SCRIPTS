import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/leader_board_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Model/leader_board_for_past_contest_model.dart';

class LeaderBoardCubit extends Cubit<LeaderBoardState> {
  LeaderBoardCubit() : super(LeaderBoardInitial());

  QuizResultModel? _allResult;
  QuizResultModel? _friendsResult;

  Future<void> fetchLeaderBoards(int contestId) async {
    print("🔄 Starting fetchLeaderBoards for contestId = $contestId");
    emit(LeaderBoardLoading());

    try {
      print("➡️ Fetching ALL leaderboard...");
      await _fetchSingle(contestId, justFriends: false);

      print("➡️ Fetching FRIENDS leaderboard...");
      await _fetchSingle(contestId, justFriends: true);

      print("✅ Both leaderboards fetched successfully!");
      emit(LeaderBoardSuccess(
        allResult: _allResult,
        friendsResult: _friendsResult,
      ));
    } catch (e, stack) {
      print("❌ Error in fetchLeaderBoards: $e");
      print(stack);
      emit(LeaderBoardError(message: e.toString()));
    }
  }

  Future<void> _fetchSingle(int contestId, {required bool justFriends}) async {
    final token = CacheHelper.getData(key: 'token') ?? '';
    if (token.isEmpty) {
      print("⚠️ No token found in cache!");
      throw Exception("No token");
    }

    final url = Urls.feachLeaderBoard(contestId, justFriends: justFriends);
    print("🌍 Requesting leaderboard API: $url (justFriends=$justFriends)");

    try {
      final response = await DioHelper.getData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📡 Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Parsing leaderboard response (justFriends=$justFriends)...");
        final quiz = QuizResultModel.fromJson(response.data);

        if (justFriends) {
          _friendsResult = quiz;
        } else {
          _allResult = quiz;
        }
      } else {
        print("❌ Failed leaderboard request: ${response.statusCode}");
        throw Exception("Failed with status: ${response.statusCode}");
      }
    } catch (e, stack) {
      print("❌ Error in _fetchSingle (justFriends=$justFriends): $e");
      print(stack);
      rethrow;
    }
  }
}
