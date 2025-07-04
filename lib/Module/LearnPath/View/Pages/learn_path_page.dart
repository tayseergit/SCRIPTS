// lib/Module/Courses/page/learnpath_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms/Module/LearnPath/Cubit/learn_path_cubit.dart';
import 'package:lms/Module/LearnPath/View/Widget/gridViewLearnPath.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';

class LearnpathPage extends StatelessWidget {
  const LearnpathPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (_) => LearnPathCubit()..getAllLearnPath(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appColors.pageBackground,
            centerTitle: true,
            title: AuthText(
              text: 'Learn Path',
              size: 24.sp,
              color: appColors.mainText,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: BlocConsumer<LearnPathCubit, LearnPathState>(
            listener: (context, state) {
              if (state is LearnPathError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.watch<LearnPathCubit>();
 
              if (state is LearnPathError) {
                return Center(child: NoConnection());
              }

              // 3) الحالة الناجحة (CourseLoaded مثلاً)
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                children: [
                  Customtextfieldsearsh(
                    onSubmit: () {
                      cubit.getAllLearnPath();
                    },
                    controller: cubit.searchController,
                    hintText: "choose learn path ?",
                  ),
                  SizedBox(height: 15.h),
                  TabButtons(
                    labels: cubit.labels,
                    selectedTab: cubit.selectedTab,
                    onTap: cubit.changeTab,
                  ),
                  SizedBox(height: 10.h),
                  state is LearnPathLoading || state is LearnPathInitial
                      ? SizedBox(height: 500.h, child: Center(child: Loading()))
                      : cubit.learningPathsResponse!.data.learningPaths.isEmpty
                          ? SizedBox(height: 500.h, child: NoItem())
                          : Gridviewlearnpath(
                              cubit: cubit,
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
