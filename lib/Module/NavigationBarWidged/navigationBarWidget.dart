// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/Contest.dart';
import 'package:lms/Module/Courses/View/Pages/courses_page.dart';
import 'package:lms/Module/LearnPath/View/Pages/learn_path_page.dart';
import 'package:lms/Module/More/more_page.dart';
import 'package:lms/Module/MyLearn/MyLearn.dart';
import 'package:lms/Module/NavigationBarWidged/navigation_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class NavigationBarwidget extends StatelessWidget {
  final List<Widget> pages = [
    CoursesPage(),
    Learnpath(),
    Contest(),
    Mylearn(),
    More(),
  ];

  NavigationBarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: pages[state],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                context.read<NavigationCubit>().changePage(index);
              },
              selectedItemColor: appColors.primary,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 0 ? appColors.primary : appColors.secondText,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      Images.navBarCourse,
                      width: 42,
                      height: 36,
                    ),
                  ),
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 1 ? appColors.primary : appColors.secondText,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      Images.navBarlearnPath,
                      width: 42,
                      height: 36,
                    ),
                  ),
                  label: 'Learn Path',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 2 ? appColors.primary : appColors.secondText,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      Images.navBarContest,
                      width: 42,
                      height: 36,
                    ),
                  ),
                  label: 'contest',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 3 ? appColors.primary : appColors.secondText,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      Images.navBarmyLearn,
                      width: 42,
                      height: 36,
                    ),
                  ),
                  label: 'MyLearn',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 4 ? appColors.primary : appColors.secondText,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      Images.navBarMore,
                      width: 42,
                      height: 36,
                    ),
                  ),
                  label: 'more',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
