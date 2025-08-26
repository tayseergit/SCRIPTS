import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_profile_model.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherContest/teacher_contest_gridview.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherCourses/teacher_courses_gridview.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherLearnPath/teacher_learnpath_gridview.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/main_header_teacher.dart';
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
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';
import 'package:lms/generated/l10n.dart';

class TeacherProfilePage extends StatelessWidget {
  final UserData? userData;
  int teacherid;
    TeacherProfilePage({
    super.key,
    this.userData,
    required this.teacherid
  });

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    print("📦 userData is: $userData");
    print("📦 userData?.id is: ${userData?.id}");

    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            print("🔥 Value of userData.id in Cubit Provider: ${userData?.id}");
            return TeacherProfileCubit()
              ..fetchTeacherProfile(teacherid);
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
              return Center(
                child: SizedBox(
                  height: 80.h,
                  child: Loading(height: 50.h, width: 50.w),
                ),
              );
            } else if (state is TeacherProfileError) {
              return Center(child: NoConnection());
            } else if (state is TeacherProfileSuccess) {
              final user = state.userModel.user;
              print(user.image);
              return ListView(
                children: [
                  MainHeader(
                    user: user,
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Profilestate(
                          title: lang.Total_Courses,
                          value: (userData?.created_courses ?? 0).toString(),
                        ),
                        Profilestate(
                          title: lang.Total_Paths,
                          value: (userData?.created_paths ?? 0).toString(),
                        ),
                        Profilestate(
                          title: lang.Total_Contests,
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
                                      return Center(
                                        child: SizedBox(
                                          height: 80.h,
                                          child: Loading(
                                              height: 50.h, width: 50.w),
                                        ),
                                      );
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
                                      return Center(
                                        child: SizedBox(
                                          height: 80.h,
                                          child: Loading(
                                              height: 50.h, width: 50.w),
                                        ),
                                      );
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
                                      return Center(
                                        child: SizedBox(
                                          height: 80.h,
                                          child: Loading(
                                              height: 50.h, width: 50.w),
                                        ),
                                      );
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
