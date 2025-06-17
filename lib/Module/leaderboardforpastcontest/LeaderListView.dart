import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/ListViewContainer.dart';
import 'package:lms/Module/leaderboardforpastcontest/card.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class LeaderListView extends StatelessWidget {
  const LeaderListView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: OnBordingContainer(
              width: 70,
              height: 30,
              color: appColors.border,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthText(
                    text: 'You: ',
                    size: 15,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w400,
                  ),
                  AuthText(
                    text: '12',
                    size: 15,
                    color: appColors.ok,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListViewContainer(
              name: 'Jackson',
              score: '1847',
              rank: '2',
              rankColor: appColors.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r)),
              image: Images.courses,
              height: 150.h,
              border: Border(
                bottom: BorderSide(color: appColors.primary, width: 4),
                left: BorderSide(color: appColors.primary, width: 4),
              ),
            ),
            ListViewContainer(
              name: 'Eiden',
              score: '2430',
              rank: '1',
              rankColor: appColors.orang,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r)),
              image: Images.courses,
              height: 200.h,
              border: Border(
                bottom: BorderSide(color: appColors.orang, width: 4),
                top: BorderSide(color: appColors.orang, width: 4),
              ),
            ),
            ListViewContainer(
              name: 'Emma Aria',
              score: '1674',
              rank: '3',
              rankColor: appColors.ok,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25.r)),
              image: Images.courses,
              height: 150.h,
              border: Border(
                bottom: BorderSide(color: appColors.ok, width: 4),
                right: BorderSide(color: appColors.ok, width: 4),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    appColors.primary,
                    appColors.pageBackground,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
            ),
            Column(
              children: [
                CardLeader(),
                CardLeader(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
