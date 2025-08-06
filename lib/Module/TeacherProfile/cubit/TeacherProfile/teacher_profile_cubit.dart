import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_profile_model.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherProfile/teacher_profile_state.dart';
import 'package:lms/Helper/dio_helper.dart';

class TeacherProfileCubit extends Cubit<TeacherProfileState> {
  TeacherProfileCubit() : super(TeacherProfileInitial());

  Future<void> fetchTeacherProfile(int id) async {
    emit(TeacherProfileLoging());

    try {
      print("1️⃣ Before fetching token");
      
    final token = CacheHelper.getData(key: 'token') ?? '';
    final userId = CacheHelper.getData(key: 'user_id');

      print("🔄 Fetching profile from: ${Urls.teacherProfile(id)}");

      

      print("2️⃣ Got token: $token");

      if (token.isEmpty || userId == null) {
      emit(TeacherProfileError(masseg: 'User is not authenticated'));
      return;
    }

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.teacherProfile(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final userProfile = UserModel.fromJson(response.data);
        print("✅ teacher fetched: ${userProfile.user}");
        emit(TeacherProfileSuccess(userModel: userProfile));
      } else {
        emit(TeacherProfileError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(TeacherProfileError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(TeacherProfileError(masseg: 'Unknown error: $e'));
    }
  }
}
