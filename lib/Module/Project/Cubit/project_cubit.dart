import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Project/Cubit/project_state.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/Model/tag_response.dart';
import 'package:lms/Module/mainWidget/loading.dart';

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
  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    getProjects();
  }

  void changeKind(int index) {
    selectedkind = index;
    emit(Selected());
    getProjects();
  }

  void getProjects() {
    selectedkind == 0 ? getAllProjects() : getUserProject();
  }

  void getProjectsTags() async {
    emit(TagsLoading());
    try {
      final response = await DioHelper.getData(
        url: "tags",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        tagResponse = TagsResponse.fromJson(value.data);
        emit(TagsSuccess());
        getProjects();
      }).catchError((error) {
        emit(Error(message: "Network error: ${error.message}"));
        print("DioException: $error");
        print(state);
      });
 
    } catch (e) {
      print("Unexpected Error: $e");
      emit(Error(message: "Unexpected error: ${e.toString()}"));
    }
  }

  void getAllProjects() async {
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
        emit(Error(message: 'fetching error'));
      }
    } on DioException catch (e) {
      emit(Error(message: "Connection Error"));
    }
  }

  void getUserProject() async {
    emit(ProjectLoading());
    try {
      print(token);
      print(userId);
      final response =
          await DioHelper.getData(url: "users/7/projects", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        projectsResponse = ProjectsResponse.fromJson(response.data);
        emit(ProjectSuccess());
      } else {
        emit(Error(message: 'fetching error'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");
        emit(Error(message: "fetching error"));
      } else {
        print("Connection Error: $e");
        emit(Error(message: "Connection Error"));
      }
    }
  }
}
