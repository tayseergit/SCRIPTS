import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_state.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';

class UserFriendCubit extends Cubit<UserFriendState> {
  UserFriendCubit() : super(UserFriendInitial());

  Future<void> fetchAllFriend(int id) async {
    emit(UserFriendLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      print("🔄 Fetching profile from: ${Urls.getAllFriend(userId)}");

      print("2️⃣ Got token: $token");

      if (token.isEmpty || userId == null) {
        emit(UserFriendError(masseg: 'User is not authenticated'));
        return;
      }

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.getAllFriend(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final friend = FriendsResponse.fromJson(response.data);
        print("📘 هل model نفسه null؟ ${friend == null}");
        print("📘 عدد الدورات داخل model: ${friend.friends}");
        print("📘 محتوى كل دورة:");

        print("✅ teacher fetched: ${friend.friends}");
        emit(UserFriendSuccess(friendsResponse: friend));
      } else {
        emit(UserFriendError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(UserFriendError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(UserFriendError(masseg: 'Unknown error: $e'));
    }
  }

  Future<void> DeletFriend(Friend friend) async {
    emit(UserFriendLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      print("🔄 Fetching profile from: ${Urls.deletFriend(userId)}");

      print("2️⃣ Got token: $token");
      print("iddddddddddddddd ${friend.id}");

      if (token.isEmpty || userId == null) {
        emit(UserFriendError(masseg: 'User is not authenticated'));
        return;
      }

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.deletData(
        url: Urls.deletFriend(friend.id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(UserFriendDeletSuccess());
        await fetchAllFriend(userId);
      } else {
        emit(UserFriendError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(UserFriendError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(UserFriendError(masseg: 'Unknown error: $e'));
    }
  }
}
