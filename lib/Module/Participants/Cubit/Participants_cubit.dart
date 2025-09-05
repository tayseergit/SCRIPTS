import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Participants/Cubit/participants_state.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  ParticipantsCubit() : super(ParticpantsInitial());

  UsersResponse? _lastResponse;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> fetchAllParticipants({bool loadMore = false}) async {
    if (_isLoadingMore ||
        (!loadMore && _currentPage == 1 && _lastResponse != null)) return;

    if (!loadMore) {
      emit(ParticpantsLoding());
      _currentPage = 1;
      _hasMore = true;
    } else {
      if (!_hasMore) return;
      _currentPage++;
      _isLoadingMore = true;
      emit(ParticpantsLoadingCards());
    }

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      if (token.isEmpty || userId == null) {
        emit(ParticpantsError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.getData(
        url: '${Urls.teacher}?role=student&page=$_currentPage',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final particpants = UsersResponse.fromJson(response.data);

        if (loadMore && _lastResponse != null) {
          _lastResponse = UsersResponse(
            status: particpants.status,
            message: particpants.message,
            users: [..._lastResponse!.users, ...particpants.users],
            meta: particpants.meta,
          );
        } else {
          _lastResponse = particpants;
        }

        _hasMore = particpants.meta.currentPage < particpants.meta.lastPage;
        _isLoadingMore = false;

        emit(ParticpantsSuccess(usersResponse: _lastResponse!));
      } else {
        _isLoadingMore = false;
        if (loadMore) _currentPage--;
        emit(ParticpantsError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      _isLoadingMore = false;
      if (loadMore) _currentPage--;
      emit(ParticpantsError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      _isLoadingMore = false;
      if (loadMore) _currentPage--;
      emit(ParticpantsError(masseg: 'Unknown error: $e'));
    }
  }

  Future<void> addFriend(TeacherModel teacher) async {
    emit(ParticpantsLoding());

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      if (token.isEmpty || userId == null) {
        emit(ParticpantsError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.postData(
        url: Urls.deletFriend(teacher.id),
        headers: {
          'Authorization': 'Bearer ${CacheHelper.getToken()}',
          'Accept': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(ParticpantsAddSuccess());
        await fetchAllParticipants();
      } else if (response.statusCode == 401) {
        emit(UnAuth());
      }
       else if (response.statusCode == 400) {
        emit(ParticpantsErrorAlreadyFriend());
      } else {
        emit(ParticpantsError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      emit(ParticpantsError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      emit(ParticpantsError(masseg: 'Unknown error: $e'));
    }
  }

  Future<void> searchParticipants(String query) async {
    emit(ParticpantsLoadingCards());
    _currentPage = 1;
    _hasMore = true;

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');
      if (token.isEmpty || userId == null) {
        emit(ParticpantsError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.getData(
        url:
            "${Urls.teacher}?role=student&search=$query&friends=0&page=$_currentPage&orderBy=points&direction=desc",
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final teacher = UsersResponse.fromJson(response.data);
        _lastResponse = teacher;
        _hasMore = teacher.meta.currentPage < teacher.meta.lastPage;
        emit(ParticpantsSuccess(usersResponse: teacher));
      } else {
        emit(ParticpantsError(
            masseg: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      emit(ParticpantsError(masseg: 'Dio error: ${e.message}'));
    } catch (e) {
      emit(ParticpantsError(masseg: 'Unknown error: $e'));
    }
  }

  UsersResponse? get lastUsers => _lastResponse;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchAllParticipantsWithOrder({
    required String orderBy,
    String direction = 'asc',
  }) async {
    emit(ParticpantsLoding());
    _currentPage = 1;
    _hasMore = true;

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      if (token.isEmpty || userId == null) {
        emit(ParticpantsError(masseg: 'User is not authenticated'));
        return;
      }

      final response = await DioHelper.getData(
        url:
            '${Urls.teacher}?role=student&page=$_currentPage&orderBy=$orderBy&direction=$direction',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final participants = UsersResponse.fromJson(response.data);
        _lastResponse = participants;
        _hasMore = participants.meta.currentPage < participants.meta.lastPage;

        emit(ParticpantsSuccess(usersResponse: participants));
      } else {
        emit(ParticpantsError(
          masseg: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      emit(ParticpantsError(masseg: 'Exception occurred: ${e.message}'));
    } catch (e) {
      emit(ParticpantsError(masseg: 'Unknown error: $e'));
    }
  }
}
