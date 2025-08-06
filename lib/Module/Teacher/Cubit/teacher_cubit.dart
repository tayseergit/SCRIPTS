import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_state.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherInitial());

  UsersResponse? _lastResponse;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> fetchAllTeacher({bool loadMore = false}) async {
    if (_isLoadingMore ||
        (!loadMore && _currentPage == 1 && _lastResponse != null)) return;

    if (!loadMore) {
      emit(TeacherLoding());
      _currentPage = 1;
      _hasMore = true;
    } else {
      if (!_hasMore) return;
      _currentPage++;
      _isLoadingMore = true;
      emit(TeacherLoadingCards());
    }

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      if (token.isEmpty || userId == null) {
        emit(TeacherError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.getData(
        url: '${Urls.teacher}?role=teacher&page=$_currentPage',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final teacher = UsersResponse.fromJson(response.data);

        if (loadMore && _lastResponse != null) {
          _lastResponse = UsersResponse(
            status: teacher.status,
            message: teacher.message,
            users: [..._lastResponse!.users, ...teacher.users],
            meta: teacher.meta,
          );
        } else {
          _lastResponse = teacher;
        }

        _hasMore = teacher.meta.currentPage < teacher.meta.lastPage;
        _isLoadingMore = false;

        emit(TeacherSuccess(usersResponse: _lastResponse!));
      } else {
        _isLoadingMore = false;
        if (loadMore) _currentPage--;
        emit(TeacherError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      _isLoadingMore = false;
      if (loadMore) _currentPage--; 
      emit(TeacherError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      _isLoadingMore = false;
      if (loadMore) _currentPage--; 
      emit(TeacherError(masseg: 'Unknown error: $e'));
    }
  }

  Future<void> searchTeacher(String query) async {
    emit(TeacherLoadingCards());
    _currentPage = 1;
    _hasMore = true;

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');
      if (token.isEmpty || userId == null) {
        emit(TeacherError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.getData(
        url:
            "${Urls.teacher}?role=teacher&search=$query&friends=0&page=$_currentPage&orderBy=points&direction=desc",
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final teacher = UsersResponse.fromJson(response.data);
        _lastResponse = teacher;
        _hasMore = teacher.meta.currentPage < teacher.meta.lastPage;
        emit(TeacherSuccess(usersResponse: teacher));
      } else {
        emit(TeacherError(
            masseg: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      emit(TeacherError(masseg: 'Dio error: ${e.message}'));
    } catch (e) {
      emit(TeacherError(masseg: 'Unknown error: $e'));
    }
  }

  UsersResponse? get lastUsers => _lastResponse;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
}
