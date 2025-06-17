import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/CardExpandCubit.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class CardLeader extends StatelessWidget {
  const CardLeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (_) => CardExpandCubit(),
      child: BlocBuilder<CardExpandCubit, bool>(
        builder: (context, isExpanded) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: appColors.mainText),
              gradient: LinearGradient(
                colors: [appColors.pageBackground, Colors.blue.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: AssetImage(Images.courses),
                    ),
                    SizedBox(width: 12.w),
                    AuthText(
                      text: 'Sebastian',
                      size: 16,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(width: 12.w),
                    AuthText(
                      text: 'points:  ',
                      size: 13,
                      color: appColors.purple,
                      fontWeight: FontWeight.w700,
                    ),
                    AuthText(
                      text: '1124',
                      size: 13,
                      color: appColors.ok,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(width: 40.w),
                    IconButton(
                      icon: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: appColors.mainText,
                      ),
                      onPressed: () {
                        context.read<CardExpandCubit>().toggle();
                      },
                    ),
                  ],
                ),
                if (isExpanded) SizedBox(height: 10.h),
                if (isExpanded)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.check, color: appColors.ok),
                          SizedBox(height: 4.h),
                          AuthText(
                            text: '18',
                            size: 14,
                            color: appColors.ok,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.close, color: appColors.red),
                          SizedBox(height: 4.h),
                          AuthText(
                            text: '2',
                            size: 14,
                            color: appColors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.hourglass_empty,
                              color: appColors.mainText),
                          SizedBox(height: 4.h),
                           AuthText(
                            text: '60 m 5 s',
                            size: 14,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                         
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
