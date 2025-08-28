import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Project/Model/tag_response.dart';
import 'package:lms/generated/l10n.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

part 'add_project_state.dart';

class AddProjectCubit extends Cubit<AddProjectState> {
  AddProjectCubit() : super(AddProjectInitial());
  TagsResponse? tagResponse;
  File? imageFile;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController gitHubController = TextEditingController();
  final TextEditingController demoController = TextEditingController();
  final TextEditingController steamController = TextEditingController();

  final List<String> selectedTechnologies = [];
  final List<String> availableTechnologies = [
    'Flutter', // Frontend (Mobile)
    'React', // Frontend (Web)
    'Angular', // Frontend (Web)
    'Laravel', // Backend (PHP)
    'Node.js', // Backend (JavaScript)
    'Python', // Backend / AI / Scripts
    'Django', // Backend (Python)
    'C++', // Game Dev / Performance Apps
    'OpenGL', // Game Dev / Graphics
    'Unity', // Game Development
    'Unreal Engine', // Game Development
    'Kali Linux', // Cybersecurity
    'Wireshark', // Cybersecurity / Network Analysis
    'Docker', // DevOps / Containers
    'GitHub Actions' // DevOps / CI-CD
  ];

  TagModel? selectedTag;

  void getProjectsTags(BuildContext context) async {
    emit(TagsLoading());

    await Future.delayed(Duration(seconds: 1));
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
          // tags = tagResponse!.tags.map((tag) => tag.name).toList();
          emit(TagsSuccess());
        } else {
          emit(TagError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        emit(TagError(message: S.of(context).error_occurred));
        print("DioException: $error");
        print(state);
      });
    } catch (e) {
      print("Unexpected Error: $e");
      emit(TagError(message: S.of(context).error_in_server));
    }
  }

  void AddProjects(BuildContext context) async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedTag == null 
        ) {
      emit(FieldRrequired());
      return;
    }

    emit(AddProjectLoading());
    try {
      MultipartFile? multipartImage;

      if (imageFile != null && imageFile!.path.isNotEmpty) {
        final filename = path.basename(imageFile!.path);

        multipartImage = await MultipartFile.fromFile(
          imageFile!.path,
          filename: filename,
          contentType: MediaType("image", "jpeg"), // أو "png" حسب نوع الصورة
        );
      }

      final formData = FormData.fromMap({
        "title": titleController.text,
        "image": multipartImage, // هنا يمكن أن تكون null
        "description": descriptionController.text,
        "technologies": selectedTechnologies,
        "links": {
          "gitHub_url": gitHubController.text.trim(),
          "demo": demoController.text.trim(),
          "steam": steamController.text.trim(),
        },
        "tag_id": selectedTag!.id,
      });
      // print(formData);
      final response = await DioHelper.postFormData(
        url: "projects",
        postData: formData,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );
      print("ddddddddddd");
      print(response.data);
      final status = response.data['status'];
      print(status);
      // الوصول إلى الرسالة
      if (response.statusCode == 200 && status == true) {
        emit(AddProjectSuccess());
      } else if (response.statusCode == 200 && status == false) {
        emit(FullMonthlyProjectError());
      } else {
        emit(AddProjectError(message: S.of(context).error_occurred));
      }
    } catch (e) {
      print("Upload error: $e");
      emit(AddProjectError(message: S.of(context).error_in_server));
    }
  }
}
