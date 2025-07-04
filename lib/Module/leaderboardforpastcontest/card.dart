import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/CardExpandCubit.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class CardLeader extends StatelessWidget {
  final int index;

  const CardLeader({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (_) => CardExpandCubit(),
      child: BlocBuilder<CardExpandCubit, bool>(
        builder: (context, isExpanded) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: appColors.mainText),
                color: appColors.pageBackground,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: isExpanded ? 133.h : 74.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appColors.blackGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: AuthText(
                      text: '$index',
                      size: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundImage: AssetImage(Images.courses),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        AuthText(
                                          text: 'Sebastian',
                                          size: 16,
                                          color: appColors.mainText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        AuthText(
                                          text: 'points : ',
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
