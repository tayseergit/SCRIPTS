import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/Contest.dart';
import 'package:lms/Module/Courses/View/Pages/courses_page.dart';
import 'package:lms/Module/LearnPath/View/Pages/learn_path_page.dart';
import 'package:lms/Module/More/more_page.dart';
import 'package:lms/Module/MyLearn/MyLearn.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class NavigationBarwidget extends StatefulWidget {
  const NavigationBarwidget({super.key});

  @override
  State<NavigationBarwidget> createState() => _NavigationBarwidgetState();
}

class _NavigationBarwidgetState extends State<NavigationBarwidget> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  final PageController _pageController = PageController();

  final List<Widget> pages = const [
    CoursesPage(),
    Learnpath(),
    Contest(),
    Mylearn(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: appColors.border,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 20.r, // responsive radius
        notchColor: appColors.border,
        removeMargins: false,
        bottomBarWidth: 800.w, // responsive width
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: TextStyle(fontSize: 10.sp), // responsive font size
        elevation: 1,
        kIconSize: 26.sp, // responsive icon size
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(appColors.secondText, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarCourse, width: 24.w, height: 24.h),
            ),
            activeItem: ColorFiltered(
              colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarCourse, width: 24.w, height: 24.h),
            ),
            itemLabel: 'Courses',
          ),
          BottomBarItem(
            inActiveItem: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(appColors.secondText, BlendMode.srcIn),
              child: Image.asset(Images.navBarlearnPath,
                  width: 24.w, height: 24.h),
            ),
            activeItem: ColorFiltered(
              colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
              child: Image.asset(Images.navBarlearnPath,
                  width: 24.w, height: 24.h),
            ),
            itemLabel: 'Learn Path',
          ),
          BottomBarItem(
            inActiveItem: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(appColors.secondText, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarContest, width: 24.w, height: 24.h),
            ),
            activeItem: ColorFiltered(
              colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarContest, width: 24.w, height: 24.h),
            ),
            itemLabel: 'Contest',
          ),
          BottomBarItem(
            inActiveItem: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(appColors.secondText, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarmyLearn, width: 24.w, height: 24.h),
            ),
            activeItem: ColorFiltered(
              colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
              child:
                  Image.asset(Images.navBarmyLearn, width: 24.w, height: 24.h),
            ),
            itemLabel: 'MyLearn',
          ),
          BottomBarItem(
            inActiveItem: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(appColors.secondText, BlendMode.srcIn),
              child: Image.asset(Images.navBarMore, width: 24.w, height: 24.h),
            ),
            activeItem: ColorFiltered(
              colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
              child: Image.asset(Images.navBarMore, width: 24.w, height: 24.h),
            ),
            itemLabel: 'More',
          ),
        ],
      ),
    );
  }
}
