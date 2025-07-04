import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/LeaderListView.dart';
import 'package:lms/Module/leaderboardforpastcontest/Tap.dart';
import 'package:lms/Module/leaderboardforpastcontest/TapCubit.dart';

class Leaderboardforpastcontestpage extends StatelessWidget {
  const Leaderboardforpastcontestpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => TapLeadercubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: appColors.pageBackground,
          body: ListView(
            padding: EdgeInsets.only(top: 140.h),
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Tap(),
                ),
              ),
              BlocBuilder<TapLeadercubit, int>(
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
    child: Text(
      text,
      style: TextStyle(color: appColors.mainText),
    ),
  );
}
