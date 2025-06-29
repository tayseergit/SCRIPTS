// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/MyLearn/CourseTabCubit.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Courses/View/Widget/TapBar_Cubit.dart';
import 'package:lms/Module/Courses/View/Widget/grid_View_Courses.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
 
    return SafeArea(
      child: BlocProvider(
        create: (context) => CourseCubit(),
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            toolbarHeight: 70.h,
            // scrolledUnderElevation: 10,
            backgroundColor: appColors.pageBackground,
            elevation: 0,
            title: Align(
              alignment: Alignment.center,
              child: AuthText(
                text: 'Courses',
                size: 24,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocBuilder<CourseCubit, CourseState>(
            builder: (context, state) {
              CourseCubit courseCubit = context.read<CourseCubit>();

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                children: [
                  Customtextfieldsearsh(
                    controller: courseCubit.searchController,
                    hintText: "choose course ?",
                  ),
                  SizedBox(height: 15.h),
                  // TabButtons(cubit: courseCubit,),
                  SizedBox(height: 10.h),
                  BlocBuilder<TabCubit, int>(
                    builder: (context, state) {
                      switch (state) {
                        case 0:
                          return Gridviewcourses();
                        case 1:
                          return Gridviewcourses();
                        case 2:
                          return Gridviewcourses();
                        case 3:
                          return _buildSimpleTab(context, 'Watchlater Content');
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleTab(BuildContext context, String text) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Center(
      child: Text(
        text,
        style: TextStyle(color: appColors.mainText),
      ),
    );
  }
}
