import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_courses_model.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherCourse/teacher_courses_state.dart';
import 'package:lms/Helper/dio_helper.dart';

class TeacherCoursesCubit extends Cubit<TeacherCoursesState> {
  TeacherCoursesCubit() : super(TeacherCoursesInitial());

  Future<void> fetchTeacherCourse(int id) async {
    emit(TeacherCoursesLoding());

    try {
      print("1️⃣ Before fetching token");

      final token = CacheHelper.getData(key: 'token') ?? '';
       

      print("🔄 Fetching profile from: ${Urls.teacherCourses(id)}");

      print("2️⃣ Got token: $token");
 

      print("3️⃣ Sending GET request with DioHelper");
      final response = await DioHelper.getData(
        url: Urls.teacherCourses(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("4️⃣ Response received: ${response.data}");
      print("✅ Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("📦 Full response data: ${response.data}");
        final teacherCourses = CourseModel.fromJson(response.data);
        print("📘 هل model نفسه null؟ ${teacherCourses == null}");
        print("📘 عدد الدورات داخل model: ${teacherCourses.courses.length}");
        print("📘 محتوى كل دورة:");
        for (var course in teacherCourses.courses) {
          print("🔹 ${course.teacherName} - ${course.id} - ${course.teacherImage}");
        }

        print("✅ teacher fetched: ${teacherCourses.courses}");
        emit(TeacherCoursesSuccess(teacherCoursesModel: teacherCourses));
      } else {
        emit(TeacherCoursesError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching Profile: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(TeacherCoursesError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(TeacherCoursesError(masseg: 'Unknown error: $e'));
    }
  }
}
