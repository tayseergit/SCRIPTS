import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_contest_model.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherContast/teacher_contest_state.dart';
import 'package:lms/Helper/dio_helper.dart';

class TeacherContestCubit extends Cubit<TeacherContestState> {
  TeacherContestCubit() : super(TeacherContestInitial());

  Future<void> fetchTeacherContest(int id) async {
    emit(TeacherContestLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ;
 
      print("🔄 Fetching profile from: ${Urls.teacherContest(id)}");

      print("2️⃣ Got token: $token");
 

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.teacherContest(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final teacherContest = TeacherContestModel.fromJson(response.data);
        print("📘 هل model نفسه null؟ ${teacherContest == null}");
        print("📘 عدد الدورات داخل model: ${teacherContest.contests}");
        print("📘 محتوى كل دورة:");
       

        print("✅ teacher fetched: ${teacherContest.contests}");
        emit(TeacherContestSuccess(teacherContestModel: teacherContest));
      } else {
        emit(TeacherContestError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(TeacherContestError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(TeacherContestError(masseg: 'Unknown error: $e'));
    }
  }
}
