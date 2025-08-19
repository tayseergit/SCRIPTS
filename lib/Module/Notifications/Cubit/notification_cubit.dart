import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Notifications/Cubit/notification_state.dart';
import 'package:lms/Module/Notifications/Model/notification_model.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_state.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      print("🔄 Fetching profile from: ${Urls.notification}");

      print("2️⃣ Got token: $token");

      if (token.isEmpty || userId == null) {
        emit(NotificationError(masseg: 'User is not authenticated'));
        return;
      }

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.notification,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final notification = NotificationResponse.fromJson(response.data);

        emit(NotificationSuccess(notificationResponse: notification));
      } else {
        emit(NotificationError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(NotificationError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(NotificationError(masseg: 'Unknown error: $e'));
    }
  }
}
