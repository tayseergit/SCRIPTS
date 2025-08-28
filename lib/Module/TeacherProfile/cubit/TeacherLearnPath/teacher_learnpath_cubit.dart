import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_learnpath_model.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherLearnPath/teacher_learnpath_state.dart';

class TeacherLearnPathCubit extends Cubit<TeacherLearnpathState> {
  TeacherLearnPathCubit() : super(TeacherLearnPathInitial());

  Future<void> fetchTeacherLearnPath(int id) async {
    emit(TeacherLearnPathLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ?? '';

      print("🔄 Fetching profile from: ${Urls.teacherLearnPath(id)}");

      print("2️⃣ Got token: $token");

      if (token.isEmpty || id == null) {
        emit(TeacherLearnPathError(masseg: 'User is not authenticated'));
        return;
      }

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.teacherLearnPath(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final teacherLearnPath = TeacherLearnPath.fromJson(response.data);
        print("📘 هل model نفسه null؟ ${teacherLearnPath == null}");
        print("📘 عدد الدورات داخل model: ${teacherLearnPath.learningPaths}");
        print("📘 محتوى كل دورة:");
        for (var learn in teacherLearnPath.learningPaths) {
          print("🔹 ${learn.teacherName} - ${learn.id} - ${learn.image}");
        }

        print("✅ teacher fetched: ${teacherLearnPath.learningPaths}");
        emit(TeacherLearnPathSuccess(teacherLearnPathModel: teacherLearnPath));
      } else {
        emit(TeacherLearnPathError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(TeacherLearnPathError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(TeacherLearnPathError(masseg: 'Unknown error: $e'));
    }
  }
}
