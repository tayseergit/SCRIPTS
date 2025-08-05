import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Project/Cubit/project_state.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/Model/tag_response.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';
import 'package:path/path.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  int selectedkind = 0;
  int selectedTab = -1;

//tags

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final searchController = TextEditingController();
  List<String> imageLabel = [
    "web",
    "mobile",
    "data",
    "game",
    "desktop",
    "ai",
    "devops",
    "other"
  ];
  TagsResponse? tagResponse;
  ProjectsResponse? projectsResponse;
  void changeTab(int index, BuildContext context) {
    selectedTab = index;
    emit(Selected());
    getProjects(context);
  }

  void changeKind(int index, BuildContext context) {
    selectedkind = index;
    emit(Selected());
    getProjects(context);
  }

  void getProjects(BuildContext context) {
    selectedkind == 0 ? getAllProjects(context) : getUserProject(context);
  }

  void getProjectsTags(BuildContext context) async {
    emit(TagsLoading());
    try {
      final response = await DioHelper.getData(
        url: "tags",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        if (value.statusCode == 200) {
          tagResponse = TagsResponse.fromJson(value.data);
          emit(TagsSuccess());
          getProjects(context);
        } else {
          emit(Error(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        emit(Error(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(Error(message: S.of(context).error_in_server));
    }
  }

  void getAllProjects(BuildContext context) async {
    emit(ProjectLoading());
    try {
      final response = await DioHelper.getData(url: "projects", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }, params: {
        "tag": tagResponse!.tags.isNotEmpty &&
                selectedTab < tagResponse!.tags.length &&
                selectedTab > 0
            ? tagResponse!.tags[selectedTab]
            : '',

        "search": searchController.text.trim(),
        // "page":"",
        // "items":"",
      });

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        projectsResponse = ProjectsResponse.fromJson(response.data);
        emit(ProjectSuccess());
      } else {
        emit(Error(message: S.of(context).error_occurred));
      }
    } catch(e) {
      emit(Error(message: S.of(context).error_in_server));
    }
  }

  void getUserProject(BuildContext context) async {
    emit(ProjectLoading());
    try {
      print("token");
      print(token);
      print(userId);
      final response =
          await DioHelper.getData(url: "users/$userId/projects", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        projectsResponse = ProjectsResponse.fromJson(response.data);
        emit(ProjectSuccess());
      } else {
        emit(Error(message: S.of(context).error_occurred));
      }
    } catch(e){
        emit(Error(message: S.of(context).error_in_server));

    }
    
  }
}
