import 'dart:math' as math;
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/View/Pages/contest_page.dart';
import 'package:lms/Module/Courses/View/Pages/courses_page.dart';
import 'package:lms/Module/LearnPath/View/Pages/learn_path_page.dart';
import 'package:lms/Module/More/more_page.dart';
import 'package:lms/Module/NavigationBarWidged/navigation_cubit.dart';
import 'package:lms/Module/Project/View/Page/projectPage.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';

class NavigationBarwidget extends StatefulWidget {
  const NavigationBarwidget({super.key});

  @override
  State<NavigationBarwidget> createState() => _NavigationBarwidgetState();
}

class _NavigationBarwidgetState extends State<NavigationBarwidget> {
  final List<Widget> pages = const [
    ContestPage(),
    LearnpathPage(),
    CoursesPage(),
    ProjectPage(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: pages[state],
            bottomNavigationBar: CurvedNavigationBar(
              index: state,
              backgroundColor: appColors.pageBackground,
              color: appColors.primary,
              buttonBackgroundColor: appColors.primary,
              height: 70.h,
              animationDuration: Duration(milliseconds: 300),
              onTap: (index) {
                context.read<NavigationCubit>().changePage(index);
              },
              items: [
                CurvedNavigationBarItem(
                    child: Image.asset(
                      Images.navBarContest,
                      width: 30,
                      height: state == 0 ? 30.h : 25.h,
                      color: state == 0
                          ? appColors.whiteText
                          : appColors.mainIconColor,
                    ),
                    label: lang.Contest,
                    labelStyle: TextStyle(
                        color: state == 0
                            ? appColors.whiteText
                            : appColors.mainIconColor,
                        fontSize: 12.sp)),
                CurvedNavigationBarItem(
                    child: Image.asset(
                      Images.navBarlearnPath,
                      width: 30,
                      height: state == 1 ? 30.h : 25.h,
                      color: state == 1
                          ? appColors.whiteText
                          : appColors.mainIconColor,
                    ),
                    label: lang.Learn_Path,
                    labelStyle: TextStyle(
                        color: state == 1
                            ? appColors.whiteText
                            : appColors.mainIconColor,
                        fontSize: 12.sp)),
                CurvedNavigationBarItem(
                    child: Image.asset(
                      Images.navBarCourse,
                      width: 30.w,
                      height: state == 2 ? 30.h : 25.h,
                      color: state == 2
                          ? appColors.whiteText
                          : appColors.mainIconColor,
                    ),
                    label: lang.courses,
                    labelStyle: TextStyle(
                        color: state == 2
                            ? appColors.whiteText
                            : appColors.mainIconColor,
                        fontSize: 12.sp)),
                CurvedNavigationBarItem(
                    child: Image.asset(
                      Images.navBarProject,
                      width: 30,
                      height: state == 3 ? 30.h : 25.h,
                      color: state == 3
                          ? appColors.whiteText
                          : appColors.mainIconColor,
                    ),
                    label: lang.Project,
                    labelStyle: TextStyle(
                        color: state == 3
                            ? appColors.whiteText
                            : appColors.mainIconColor,
                        fontSize: 12.sp)),
                CurvedNavigationBarItem(
                    child: Image.asset(
                      Images.navBarMore,
                      width: 30,
                      height: state == 4 ? 30.h : 25.h,
                      color: state == 4
                          ? appColors.whiteText
                          : appColors.mainIconColor,
                    ),
                    label: lang.More,
                    labelStyle: TextStyle(
                        color: state == 4
                            ? appColors.whiteText
                            : appColors.mainIconColor,
                        fontSize: 12.sp)),
              ],
            ),
          );
        },
      ),
    );
  }
}
