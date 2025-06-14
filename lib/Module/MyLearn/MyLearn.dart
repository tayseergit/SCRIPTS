// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/LearnPath/View/Widget/gridViewLearnPath.dart';
import 'package:lms/Module/MyLearn/CourseTabCubit.dart';
import 'package:lms/Module/MyLearn/SectionCubit.dart';
import 'package:lms/Module/MyLearn/TabButtonsss.dart';
import 'package:lms/Module/MyLearn/gridViewMyLearn.dart';
import 'package:lms/Module/MyLearn/mylearnMainTabButton.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Mylearn extends StatelessWidget {
  const Mylearn({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SectionCubit()),
        BlocProvider(create: (_) => CourseTabCubit()),
        BlocProvider(create: (_) => PathTabCubit()),
      ],
      child: Scaffold(
        backgroundColor:appColors.pageBackground,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor:appColors.pageBackground,
          title: Center(
            child: AuthText(
              text: 'Learn',
              size: 24,
              color: appColors.mainText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
             
              BlocBuilder<SectionCubit, int>(
                builder: (context, sectionIndex) {
                  return Row(
                    children: [
                      MainTabButton(
                        title: "My Course",
                        index: 0,
                        selectedIndex: context.watch<SectionCubit>().state,
                      ),
                      MainTabButton(
                        title: "My Path",
                        index: 1,
                        selectedIndex: context.watch<SectionCubit>().state,
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 23.h),

              // Secondary Tabs
              BlocBuilder<SectionCubit, int>(
                builder: (context, sectionIndex) {
                  return BlocBuilder<Cubit<int>, int>(
                    bloc:
                        sectionIndex == 0
                            ? context.read<CourseTabCubit>()
                            : context.read<PathTabCubit>(),
                    builder: (context, tabIndex) {
                      return TabButtonsss(
                        labels: ['All', 'Enroll', 'Completed', 'Watchlater'],
                        selectedIndex: tabIndex,
                        onTabChange: (i) {
                          if (sectionIndex == 0) {
                            context.read<CourseTabCubit>().changeTab(i);
                          } else {
                            context.read<PathTabCubit>().changeTab(i);
                          }
                        },
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 16),

              // Content Based on Tabs
              Expanded(
                child: BlocBuilder<SectionCubit, int>(
                  builder: (context, sectionIndex) {
                    return BlocBuilder<Cubit<int>, int>(
                      bloc:
                          sectionIndex == 0
                              ? context.read<CourseTabCubit>()
                              : context.read<PathTabCubit>(),
                      builder: (context, tabIndex) {
                        if (sectionIndex == 0) {
                          // My Courses Tabs
                          return _buildCourseContent(tabIndex);
                        } else {
                          // My Path Tabs
                          return _buildPathContent(tabIndex);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseContent(int index) {
    switch (index) {
      case 0:
        return Gridviewmylearn();
      case 1:
        return Text('Enrolled Courses');
      case 2:
        return Text('Completed Courses');
      case 3:
        return Text('Watchlater Courses');
      default:
        return SizedBox();
    }
  }

  Widget _buildPathContent(int index) {
    switch (index) {
      case 0:
        return Gridviewlearnpath(); 
      case 1:
        return Text('Enrolled Paths');
      case 2:
        return Text('Completed Paths');
      case 3:
        return Text('Watchlater Paths');
      default:
        return SizedBox();
    }
  }
}
