import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Courses/Model/course_response.dart';
import 'package:lms/generated/l10n.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  Timer? _debounce;
  CourseCubit({required this.context}) : super(CourseInitial());
  BuildContext context;
  TextEditingController searchController = TextEditingController();
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  final labels = ['All', 'Enroll', 'Completed', 'Watch later'];
  int selectedTab = 0;
  bool isLoading = false;
  List<Course> allCourses = [];

  int currentPage = 1;
  bool hasMorePages = true;
  CoursesResponse? courseResponse;

  List<String> getLabels(BuildContext context) {
    return [
      S.of(context).All,
      S.of(context).enroll,
      S.of(context).Completed,
      S.of(context).watchLater,
    ];
  }

   void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      reset();
      getAllCourse();
    });
  }

  void reset() {
    currentPage = 1;
    hasMorePages = true;

    allCourses.clear();
  }

  void changeTab(int index) {
    selectedTab = index;
    emit(Selected());
    reset();
    getAllCourse();
  }

  void getAllCourse() async {
    if (!hasMorePages || isLoading) {
      debugPrint("🚫 لا مزيد من الصفحات أو جاري التحميل");
      return;
    }

    isLoading = true;
    if (currentPage == 1) {
      debugPrint("⏳ بدء تحميل الصفحة الأولى");
      emit(CourseLoading());
    } else {
      debugPrint("⏳ تحميل الصفحة $currentPage");
    }

    try {
      final response = await DioHelper.getData(
        url: "courses",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {
          'page': currentPage,
          'orderBy': 'rate',
          'direction': 'desc',
          'status': selectedTab == 1
              ? "enrolled"
              : selectedTab == 2
                  ? "finished"
                  : selectedTab == 3
                      ? "watch_later"
                      : "all",
          'search': searchController.text.trim(),
        },
      );

      debugPrint("✅ استلمت استجابة من السيرفر: ${response.statusCode}");

      if (response.statusCode == 200) {
        courseResponse = CoursesResponse.fromJson(response.data);
        hasMorePages = courseResponse!.data.hasMorePages;
        allCourses.addAll(courseResponse!.data.courses);

        debugPrint("📄 عدد الدورات الحالية: ${allCourses.length}");
        debugPrint("📌 هل هناك صفحات إضافية؟ $hasMorePages");

        if (hasMorePages) currentPage++;
        emit(CourseSuccess());
      } else {
        debugPrint("⚠️ خطأ في الاستجابة: ${response.statusCode}");
        emit(CourseError(message: "خطأ في الاستجابة: ${response.statusCode}"));
      }
    } on SocketException catch (e) {
      debugPrint("❌ SocketException: $e");
      emit(CourseError(message: S.of(context).error_in_server));
    } on DioException catch (e) {
      debugPrint("❌ DioException: ${e.message}");
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("⏰ مهلة الاتصال تجاوزت الحد");
        emit(CourseError(message: S.of(context).error_in_server));
      } else if (e.response != null) {
        debugPrint(
            "⚠️ استجابة السيرفر: ${e.response?.statusCode} - ${e.response?.data}");
        emit(CourseError(
            message: "حدث خطأ في السيرفر: ${e.response?.statusCode}"));
      } else {
        emit(CourseError(message: S.of(context).error_in_server));
      }
    } catch (e, stackTrace) {
      debugPrint("❌ خطأ غير متوقع: $e");
      debugPrint("📝 StackTrace: $stackTrace");
      emit(CourseError(message: S.of(context).error_in_server));
    } finally {
      isLoading = false;
      debugPrint("🔄 انتهاء عملية التحميل");
    }
  }
}
/** on SocketException catch (e) {
      debugPrint('SocketException: $e');
      emit(
        CourseError(
          message: S.of(context).error_in_server,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(CourseError(message: S.of(context).error_in_server));
      } else if (e.response != null) {
        emit(CourseError(
            message: "حدث خطأ في السيرفر: ${e.response?.statusCode}"));
      } else {
        emit(CourseError(message: S.of(context).error_in_server));
      }
    } */
