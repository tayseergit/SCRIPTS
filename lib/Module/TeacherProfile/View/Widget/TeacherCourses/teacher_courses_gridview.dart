import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_courses_model.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherCourses/teacher_courses_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class Teachercoursesgridview extends StatelessWidget {
  final List<TeacherCourse> list;
  Teachercoursesgridview({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    print(list);
    ThemeState appColors = context.watch<ThemeCubit>().state;

    if (list.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }

    return Container(
      height: 510.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180.w,
          childAspectRatio: 180.w / 250.h,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        itemBuilder: (ctx, index) {
          final courses = list[index];
          return Teachercoursescard(
            teacherCoursesModel: courses,
          );
        },
      ),
    );
  }
}
