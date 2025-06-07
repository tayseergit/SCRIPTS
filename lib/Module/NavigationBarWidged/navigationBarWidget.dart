// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/Contest.dart';
import 'package:lms/Module/Courses/Courses.dart';
import 'package:lms/Module/LearnPath/LearnPath.dart';
import 'package:lms/Module/More/More.dart';
import 'package:lms/Module/MyLearn/MyLearn.dart';
import 'package:lms/Module/NavigationBarWidged/navigation_cubit.dart';

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
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      state == 0 ? AppColors.primary : AppColors.gray,
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
                      state == 1 ? AppColors.primary : AppColors.gray,
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
                      state == 2 ? AppColors.primary : AppColors.gray,
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
                      state == 3 ? AppColors.primary : AppColors.gray,
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
                      state == 4 ? AppColors.primary : AppColors.gray,
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
