import 'package:bloc/bloc.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';

class LearnPathInfoCubit extends Cubit<LearnPathInfoState> {
  LearnPathInfoCubit() : super(LearnPathInfoInitial());

  Future<void> fetchAllLearnPathData(int id) async {
    emit(LearnPathInfoLoding());

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      if (token.isEmpty || userId == null) {
        emit(LearnPathInfoError(masseg: 'User is not authenticated'));
        return;
      }

      print("🔄 Fetching learn path info from: ${Urls.learnPathInfo(id)}");
      final infoResponse = await DioHelper.getData(
        url: Urls.learnPathInfo(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (infoResponse.statusCode != 200) {
        emit(LearnPathInfoError(masseg: 'Failed to fetch path info'));
        return;
      }

      final info = LearningPathInfoModel.fromJson(infoResponse.data);
      print("✅ Info fetched");

      print("🔄 Fetching learn path courses from: ${Urls.learnPathInfocourse(id)}");
      final coursesResponse = await DioHelper.getData(
        url: Urls.learnPathInfocourse(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (coursesResponse.statusCode != 200) {
        emit(LearnPathInfoError(masseg: 'Failed to fetch path courses'));
        return;
      }

      final courses = LearnPathInfoCourseResponse.fromJson(coursesResponse.data);
      print("✅ Courses fetched");

      emit(LearnPathAllDataSuccess(info: info, courses: courses));
    } catch (e) {
      print("❌ Error while fetching data: $e");
      emit(LearnPathInfoError(masseg: 'Exception occurred: $e'));
    }
  }
}
