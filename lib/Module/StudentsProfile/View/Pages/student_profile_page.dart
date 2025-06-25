import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Courses/View/Widget/TapBar_Cubit.dart';
import 'package:lms/Module/StudentsProfile/Model/student_profile_model.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/achievement_gridView.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/certificate_gridVeiw.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/contest_profile_widget.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';

class StudentProfilePage extends StatelessWidget {
  StudentProfilePage({super.key});
  StudentProfileModel? studentProfileModel;
  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabCubitProfile()),
        BlocProvider(create: (_) => StudentProfileCubit()..getProfile()),
      ],
      child: BlocConsumer<StudentProfileCubit, StudentProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            CustomSnackbar.show(
              context: context,
              duration: 4,
              fillColor: appColors.red,
              message: state.message,
            );
          }
          if (state is ProfileSuccess) {
            studentProfileModel = state.student;
            print(studentProfileModel?.name);
          }
        },
        builder: (context, state) {
          StudentProfileCubit studentModel = StudentProfileCubit.get(context);

          return Container(
            color: appColors.pageBackground,
            child: SafeArea(
                child: Scaffold(
              backgroundColor: appColors.pageBackground,
              body: Builder(
                builder: (context) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: SizedBox(
                        height: 80.h,
                        child: Loading(height: 50.h, width: 50.w),
                      ),
                    );
                  }
                  if (state is ProfileError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is ProfileSuccess) {
                    return _buildProfileContent(context, appColors);
                  } else {
                    return _buildProfileContent(context, appColors);
                  }
                },
              ),
            )),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ThemeState appColors) {
    StudentProfileCubit studentCubit = StudentProfileCubit.get(context);

    return Column(
      children: [
        _buildHeader(context, appColors),
        SizedBox(height: 12.h),
        _buildProfileStats(context),
        SizedBox(height: 12.h),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TabButtonsProfile(),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<TabCubitProfile, int>(
          builder: (context, state) {
            switch (state) {
              case 0:
                return CirtificateGridview(
                  cubit: studentCubit,
                );
              case 1:
                return AchievementGridview(cubit: studentCubit);
              case 2:
                return ContestHistoryCard(cubit: studentCubit,);
              case 3:
                return _buildSimpleTab(context, 'Watchlater Content');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ThemeState appColors) {
    StudentProfileCubit studentModel = StudentProfileCubit.get(context);

    return Stack(
      children: [
        Image.asset(
          Images.courses,
          width: double.infinity,
          height: 300.h,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h, right: 15.w),
          child: Align(
            alignment: Alignment.topRight,
            child: OnBoardingContainer(
              width: 90.w,
              height: 25.h,
              color: appColors.darkText,
              widget: AuthText(
                text: 'Edit Profile',
                size: 14.sp,
                color: appColors.mainText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OnBoardingContainer(
                width: 220.w,
                height: 68.h,
                color: appColors.primary,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthText(
                      text: studentModel.studentProfileModel.name,
                      size: 18.sp,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                    AuthText(
                      text: studentModel.studentProfileModel.email,
                      size: 10.sp,
                      color: appColors.pageBackground,
                      fontWeight: FontWeight.w700,
                    ),
                    AuthText(
                      text: studentModel.studentProfileModel.joined,
                      size: 10.sp,
                      color: appColors.pageBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5.sp),
              Column(
                children: [
                  OnBoardingContainer(
                    width: 110.w,
                    height: 30.h,
                    color: appColors.orang,
                    widget: Center(
                      child: AuthText(
                        text: studentModel.studentProfileModel.level,
                        size: 12.sp,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  OnBoardingContainer(
                    width: 110.w,
                    height: 30.h,
                    color: appColors.darkText,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.github,
                          height: 20.h,
                          width: 20.w,
                          color: appColors.mainText,
                        ),
                        SizedBox(width: 15.w),
                        AuthText(
                          text: 'GitHub',
                          size: 12.sp,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStats(BuildContext context) {
    StudentProfileCubit studentModel = StudentProfileCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Profilestate(
              title: 'Current Streak',
              value: '${studentModel.studentProfileModel.points} Days'),
          Profilestate(
              title: 'Course Completed',
              value: "${studentModel.studentProfileModel.completedCourses}"),
          Profilestate(
              title: 'Path Completed',
              value:
                  "${studentModel.studentProfileModel.completedLearningPaths}"),
          Profilestate(
              title: 'Total Points',
              value: "${studentModel.studentProfileModel.points}"),
        ],
      ),
    );
  }

  Widget _buildSimpleTab(BuildContext context, String text) {
    final appColors = context.watch<ThemeCubit>().state;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: appColors.mainText,
          ),
        ),
      ),
    );
  }
}
