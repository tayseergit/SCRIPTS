import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_profile_model.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherContest/teacher_contest_gridview.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherCourses/teacher_courses_gridview.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherLearnPath/teacher_learnpath_gridview.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherContast/teacher_contest_cubit.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherContast/teacher_contest_state.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherCourse/teacher_courses_cubit.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherCourse/teacher_courses_state.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherLearnPath/teacher_learnpath_cubit.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherLearnPath/teacher_learnpath_state.dart';
import 'package:lms/Module/TeacherProfile/cubit/tab_teacher_cubit.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherProfile/teacher_profile_cubit.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherProfile/teacher_profile_state.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/tab_teacher.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class TeacherProfilePage extends StatelessWidget {
  final UserData? userData;
  const TeacherProfilePage({
    super.key,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    print("📦 userData is: $userData");
    print("📦 userData?.id is: ${userData?.id}");

    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            print("🔥 Value of userData.id in Cubit Provider: ${userData?.id}");
            return TeacherProfileCubit()
              ..fetchTeacherProfile(userData?.id ?? 0);
          },
        ),
        BlocProvider(create: (_) => Tabteachercubit()),
        BlocProvider(
            create: (_) =>
                TeacherCoursesCubit()..fetchTeacherCourse(userData?.id ?? 0)),
        BlocProvider(
            create: (_) => TeacherLearnPathCubit()
              ..fetchTeacherLearnPath(userData?.id ?? 0)),
        BlocProvider(
            create: (_) =>
                TeacherContestCubit()..fetchTeacherContest(userData?.id ?? 0)),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<TeacherProfileCubit, TeacherProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TeacherProfileLoging) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TeacherProfileError) {
              return Center(child: NoConnection());
            } else if (state is TeacherProfileSuccess) {
              final user = state.userModel.user;
              print(user.image);
              return ListView(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        user.image ?? '',
                        width: double.infinity,
                        height: 380,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Images.allProject,
                            width: double.infinity,
                            height: 380,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, right: 15.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: OnBoardingContainer(
                            width: 90,
                            height: 25,
                            color: appColors.darkText,
                            widget: AuthText(
                              text: 'Edit Profile',
                              size: 14,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OnBoardingContainer(
                                width: 220,
                                height: 80,
                                color: appColors.primary,
                                widget: Column(
                                  children: [
                                    AuthText(
                                      text: user.name ?? '',
                                      size: 24,
                                      color: appColors.mainText,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    AuthText(
                                      text: user.email ?? '',
                                      size: 14,
                                      color: appColors.pageBackground,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    AuthText(
                                      text: user.joined ?? '',
                                      size: 14,
                                      color: appColors.pageBackground,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                children: [
                                  OnBoardingContainer(
                                    width: 110,
                                    height: 35,
                                    color: appColors.orang,
                                    widget: Align(
                                      alignment: Alignment.center,
                                      child: AuthText(
                                        text: 'Intermediate',
                                        size: 12,
                                        color: appColors.mainText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  OnBoardingContainer(
                                    width: 110,
                                    height: 35,
                                    color: appColors.darkText,
                                    widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          color: appColors.mainText,
                                          size: 12,
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
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Profilestate(
                          title: 'Total Courses',
                          value: (userData?.created_courses ?? 0).toString(),
                        ),
                        Profilestate(
                          title: 'Total Paths',
                          value: (userData?.created_paths ?? 0).toString(),
                        ),
                        Profilestate(
                          title: 'Total Contests',
                          value: (userData?.created_contests ?? 0).toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Tabteacher(),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Builder(
                      builder: (context) {
                        return BlocBuilder<Tabteachercubit, int>(
                          builder: (context, tabIndex) {
                            switch (tabIndex) {
                              case 0:
                                return BlocBuilder<TeacherCoursesCubit,
                                    TeacherCoursesState>(
                                  builder: (context, state) {
                                    if (state is TeacherCoursesLoding) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is TeacherCoursesSuccess) {
                                      final list =
                                          state.teacherCoursesModel.courses;
                                      return Teachercoursesgridview(list: list);
                                    } else if (state is TeacherCoursesError) {
                                      return Center(
                                        child: Text(
                                          state.masseg,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );

                              case 1:
                                return BlocBuilder<TeacherLearnPathCubit,
                                    TeacherLearnpathState>(
                                  builder: (context, state) {
                                    if (state is TeacherLearnPathLoding) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state
                                        is TeacherLearnPathSuccess) {
                                      final learnPathlist = state
                                          .teacherLearnPathModel.learningPaths;
                                      return TeacherLearnpathGridview(
                                          LearnPathlist: learnPathlist);
                                    } else if (state is TeacherLearnPathError) {
                                      return Center(
                                        child: Text(
                                          state.masseg,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );
                              case 2:
                                return BlocBuilder<TeacherContestCubit,
                                    TeacherContestState>(
                                  builder: (context, state) {
                                    if (state is TeacherContestLoding) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is TeacherContestSuccess) {
                                      final contestlist =
                                          state.teacherContestModel.contests;
                                      return TeacherContestGridview(
                                          teacherContest: contestlist);
                                    } else if (state is TeacherContestError) {
                                      return Center(
                                        child: Text(
                                          state.masseg,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );
                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
