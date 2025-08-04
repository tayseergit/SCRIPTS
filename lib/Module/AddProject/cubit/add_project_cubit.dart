import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Project/Model/tag_response.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'add_project_state.dart';

class AddProjectCubit extends Cubit<AddProjectState> {
  AddProjectCubit() : super(AddProjectInitial());
  TagsResponse ? tagResponse;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController gitHubController = TextEditingController();
  final TextEditingController demoController = TextEditingController();
  final TextEditingController steamController = TextEditingController();

  final List<String> selectedTechnologies = [];
  final List<String> availableTechnologies = [
    'C++',
    'OpenGL',
    'Python',
    'JavaScript',
    'Flutter'
  ];
  final List<String> tags = ['Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'];
  String? selectedTag;

  void getProjectsTags(BuildContext context) async {
    emit(TagsLoading());
    try {
      final response = await DioHelper.getData(
        url: "tags",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      ).then((value) {
        if (value.statusCode == 200) {
          tagResponse = TagsResponse.fromJson(value.data);
          emit(TagsSuccess());
        } else {
          emit(AddProjectError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        emit(AddProjectError(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(AddProjectError(message: S.of(context).error_in_server));
    }
  }

void AddProjects(BuildContext context) async {
    emit(AddProjectLoading());
    try {
      final response = await DioHelper.postData(
        url: "addproject",
        postData: {
          
        },
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      ).then((value) {
        if (value.statusCode == 200) {
          
          emit(AddProjectSuccess());
        } else {
          emit(AddProjectError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        emit(AddProjectError(message: S.of(context).error_occurred));
         print(state);
      });
    } catch (e) {
       emit(AddProjectError(message: S.of(context).error_in_server));
    }
  }

}
