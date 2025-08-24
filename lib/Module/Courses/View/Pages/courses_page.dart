// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Courses/View/Widget/grid_View_Courses.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return SafeArea(
      child: BlocProvider(
        create: (_) => CourseCubit(context:context )..getAllCourse(),
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            toolbarHeight: 70.h,
            elevation: 0,
            backgroundColor: appColors.pageBackground,
            title: Center(
              child: AuthText(
                text: S.of(context).courses,
                size: 24.sp,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocConsumer<CourseCubit, CourseState>(
            listener: (context, state) {
              if (state is CourseError) {
                customSnackBar(
                    context: context, success: 0, message: state.message);
              }
            },
            builder: (context, state) {
              final cubit = context.watch<CourseCubit>();

              if (state is CourseError) {
                return Center(child: NoConnection());
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                children: [
                  Customtextfieldsearsh(
                    onSubmit: () {
                      cubit.getAllCourse();
                    },
                    controller: cubit.searchController,
                    hintText: S.of(context).choose_course,
                  ),
                  SizedBox(height: 15.h),
                  TabButtons(
                    labels: cubit.getLabels(context),
                    selectedTab: cubit.selectedTab,
                    onTap: cubit.changeTab,
                  ),
                  SizedBox(height: 10.h),
                  state is CourseLoading || state is CourseInitial
                      ? SizedBox(height: 500.h, child: Center(child: Loading()))
                      : state is CourseError
                          ? SizedBox(height: 500.h, child: NoConnection())
                          : cubit.courseResponse!.data.courses.isEmpty
                              ? Center(
                                  heightFactor: 2.5,
                                  child:
                                      SizedBox(height: 200.h, child: NoItem()),
                                )
                              : Gridviewcourses(cubit: cubit),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
