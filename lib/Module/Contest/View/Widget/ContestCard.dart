import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Contest/Model/contest_response.dart';
import 'package:lms/Module/ContestTest/View/Pages/contest_Test_Page.dart';
import 'package:lms/Module/CourseInfo/View/Pages/course_info_page.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/leader_board_cubit.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Pages/leaderboardforpastcontestPage.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/ReadMoreInlineText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';

class Contestcard extends StatelessWidget {
  Contestcard({super.key, required this.contest});
  Contest contest;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    final status = contest.status;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: OnBoardingContainer(
          radius: 20.r,
          boarderColor: appColors.blackGreen,
          color: appColors.pageBackground,
          widget: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.h, top: 10.h),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250.w,
                            child: AuthText(
                              text: contest.name,
                              size: 20,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AuthText(
                            text: 'Description:',
                            size: 15,
                            color: appColors.secondText,
                            fontWeight: FontWeight.w700,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ReadMoreInlineText(
                              text: contest.description,
                              trimLength: 19,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          AuthText(
                            text: contest.type,
                            size: 15,
                            color: appColors.purple,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Images.contest4,
                                    height: 15.h,
                                    width: 15.w,
                                    color: appColors.primary,
                                  ),
                                  SizedBox(width: 3.w),
                                  AuthText(
                                    text: contest.startAt,
                                    size: 14,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15.w),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Image.asset(
                                Images.contest5,
                                height: 15.h,
                                width: 15.w,
                                color: appColors.primary,
                              ),
                              SizedBox(width: 3.w),
                              AuthText(
                                text: "${contest.time} min",
                                size: 14,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          status == "ended"
                              ? OnBoardingContainer(
                                  radius: 20,
                                  width: 130,
                                  height: 40,
                                  color: appColors.blackGreen,
                                  widget: AuthText(
                                    text: lang.Leader_Board,
                                    size: 16,
                                    color: appColors.whiteText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  onTap: () {
                                    if (CacheHelper.getToken() == null) {
                                      showNoAuthDialog(context);
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                            value: LeaderBoardCubit(),
                                            child:
                                                Leaderboardforpastcontestpage(
                                              contestId: contest.id,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              : Container(),
                          SizedBox(height: 10.h),
                        ]),
                    Column(
                      children: [
                        OnBoardingContainer(
                          width: 70.w,
                          height: 20.h,
                          color: appColors.ok,
                          widget: AuthText(
                            text: status,
                            size: 10,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              Images.cup,
                              width: 75.w,
                              height: 100.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: AuthText(
                                text: status == "active"
                                    ? lang.join
                                    : status == "coming"
                                        ? lang.contest_register
                                        : "",
                                size: 10,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            if (CacheHelper.getToken() == null) {
              showNoAuthDialog(context);
              return;
            }
            if (contest.type == "programming" || contest.alreadyParticipate! ) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: appColors.primary.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: AuthText(
                      text: contest.alreadyParticipate!
                          ? lang.contest_already_participate
                          : lang.You_cant_open_programming_contest_now,
                      color: appColors.mainText,
                      fontWeight: FontWeight.bold,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      size: 15.sp,
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            lang.done,
                            style: TextStyle(
                                color: appColors.mainText, fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (contest.status == "coming") {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: appColors.primary.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: AuthText(
                      text: lang.wait_until_the_contest_open,
                      color: appColors.mainText,
                      fontWeight: FontWeight.bold,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      size: 15.sp,
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            lang.done,
                            style: TextStyle(
                                color: appColors.mainText, fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else
              pushTo(
                  context: context,
                  toPage: ContestTestPage(contestId: contest.id));
            print(contest.id);
          },
        ),
      ),
    );
  }
}
