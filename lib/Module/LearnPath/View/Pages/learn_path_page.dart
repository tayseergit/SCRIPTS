// lib/Module/Courses/page/learnpath_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms/Module/LearnPath/Cubit/learn_path_cubit.dart';
import 'package:lms/Module/LearnPath/View/Widget/gridViewLearnPath.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/generated/l10n.dart';

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
            toolbarHeight: 70.h,
            elevation: 0,
            backgroundColor: appColors.pageBackground,
            centerTitle: true,
            title: AuthText(
              text: S.of(context).Learn_Path,
              size: 24.sp,
              color: appColors.mainText,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: BlocConsumer<LearnPathCubit, LearnPathState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = context.watch<LearnPathCubit>();

              if (state is LearnPathError) {
                return Center(child: NoConnection());
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                children: [
                  Customtextfieldsearsh(
                    onSubmit: () {
                      cubit.getAllLearnPath();
                    },
                    controller: cubit.searchController,
                    hintText: S.of(context).choose_learn_path,
                  ),
                  SizedBox(height: 15.h),
                  TabButtons(
                    labels: cubit.getLabels(context),
                    selectedTab: cubit.selectedTab,
                    onTap: cubit.changeTab,
                  ),
                  SizedBox(height: 10.h),
                  state is LearnPathLoading || state is LearnPathInitial
                      ? SizedBox(height: 500.h, child: Center(child: Loading()))
                      : cubit.learningPathsResponse!.data.learningPaths.isEmpty
                          ? Center(
                              heightFactor: 2.5,
                              child: SizedBox(height: 200.h, child: NoItem()))
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
