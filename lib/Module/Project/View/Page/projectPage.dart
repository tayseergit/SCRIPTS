import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Project/View/Widget/Swich.dart';
import 'package:lms/Module/Project/View/Widget/TapProject.dart';
import 'package:lms/Module/Project/View/Widget/TapBarCubit.dart';
import 'package:lms/Module/Project/View/Widget/TapBarPage.dart';
import 'package:lms/Module/Project/View/Widget/gridViewProject.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/LeaderListView.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';

class Projectpage extends StatelessWidget {
  const Projectpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final search = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TapbarcubitProject()),
        BlocProvider(create: (_) => Swich()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: appColors.pageBackground,
            elevation: 0,
            title: Align(
              alignment: Alignment.center,
              child: AuthText(
                text: 'Project',
                size: 24,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            children: [
              Customtextfieldsearsh(
                onSubmit: () {
                  // contestCubit.getContest();
                },
                controller: search,
                hintText: 'search project ...',
              ),
              SizedBox(
                height: 20.h,
              ),

              TabButtonsProject(),
              SizedBox(width: 10.w),
              // TapProsject(),

              BlocBuilder<TapbarcubitProject, int>(
                builder: (context, state) {
                  switch (state) {
                    case 0:
                      return Gridviewproject();
                    case 1:
                      return _buildSimpleTab(context, 'In Progress Content');
                    case 2:
                      return _buildSimpleTab(context, 'Completed Content');
                    case 3:
                      return _buildSimpleTab(context, 'Watchlater Content');
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              BlocBuilder<Swich, int>(
                builder: (context, state) {
                  switch (state) {
                    case 0:
                      return LeaderListView();
                    case 1:
                      return _buildSimpleTab(context, 'Enroll Content');
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget _buildSimpleTab(BuildContext context, String text) {
  ThemeState appColors = context.watch<ThemeCubit>().state;

  return Center(
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        text,
        style: TextStyle(
          color: appColors.mainText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
