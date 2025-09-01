import 'dart:async';

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
  List<ProjectModel> allProjects = [];

  // Pagination variables
  int currentPage = 1;
  bool hasMorePages = true;
  bool isLoading = false;
  //tags

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  Timer? _debounce;

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

  void resetProjects() {
    currentPage = 1;
    hasMorePages = true;
    isLoading = false;
    allProjects.clear();
  }

  void changeTab(int index, BuildContext context) {
    selectedTab = index;

    emit(Selected());
    resetProjects();
    getProjects(context);
  }

  void onSearchChanged(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      resetProjects();
      getProjects(context);
    });
  }

  void changeKind(int index, BuildContext context) {
    selectedkind = index;
    emit(Selected());
    resetProjects();

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
    if (!hasMorePages || isLoading) return;
    isLoading = true;

    if (currentPage == 1) emit(ProjectLoading());

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
        "page": currentPage,
        "items": 20,
      }).then((response) {
        if (response.statusCode == 200) {
          projectsResponse = ProjectsResponse.fromJson(response.data);
          allProjects.addAll(projectsResponse!.data);

          final meta = projectsResponse!.meta;
          hasMorePages = meta.currentPage < meta.lastPage;
          currentPage = meta.currentPage + 1;
          if (hasMorePages) currentPage++;
          emit(ProjectSuccess());
        } else {
          emit(Error(message: response.data['message']));
        }
      }).catchError((response) {
        emit(Error(message: S.of(context).error_occurred));
      });
    } catch (e) {
      print(e.toString());
      emit(Error(message: S.of(context).error_in_server));
    } finally {
      isLoading = false;
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
      }).then((response) {
        if (response.statusCode == 200) {
          projectsResponse = ProjectsResponse.fromJson(response.data);
          allProjects.addAll(projectsResponse!.data);

          final meta = projectsResponse!.meta;
          hasMorePages = meta.currentPage < meta.lastPage;
          currentPage = meta.currentPage + 1;
          if (hasMorePages) currentPage++;
          emit(ProjectSuccess());
        } else {
          emit(Error(message: response.data['message']));
        }
      }).catchError((response) {
        emit(Error(message: S.of(context).error_occurred));
      });
    } catch (e) {
      emit(Error(message: S.of(context).error_in_server));
    } finally {
      isLoading = false;
    }
  }
}
