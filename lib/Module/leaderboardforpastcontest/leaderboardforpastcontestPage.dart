import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Tap.dart';
import 'package:lms/Module/leaderboardforpastcontest/TapCubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';

class Leaderboardforpastcontestpage extends StatelessWidget {
  const Leaderboardforpastcontestpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => Tapcubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: appColors.pageBackground,
            body: ListView(
              padding: EdgeInsets.only(top: 140.h,right: 15.w),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: OnBordingContainer(
                    width: 150,
                    height: 50,
                    color: appColors.seocndIconColor,
                    widget: Tap(),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
