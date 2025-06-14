import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Setting/NotificationSwitchCubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NotificationSwitchPushNotificationsCubit()),
        BlocProvider(create: (context) => NotificationSwitchDarkModeCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: appColors.pageBackground,
          body: ListView(
            children: [
              SizedBox(
                height: 140.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                        width: 330,
                        height: 60,
                        color: appColors.pageBackground,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: 'Push notifications',
                                size: 18,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w400,
                              ),
                              BlocBuilder<
                                  NotificationSwitchPushNotificationsCubit,
                                  bool>(
                                builder: (context, isSwitched) {
                                  return Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      context
                                          .read<
                                              NotificationSwitchPushNotificationsCubit>()
                                          .toggleSwitch(value);
                                    },
                                    activeColor: appColors.pageBackground,
                                    activeTrackColor: appColors.seocndIconColor,
                                    inactiveThumbColor:
                                        appColors.pageBackground,
                                    inactiveTrackColor: appColors.secondText,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                        width: 330,
                        height: 60,
                        color: appColors.pageBackground,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: 'Dark Mode',
                                size: 18,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w400,
                              ),
                              BlocBuilder<NotificationSwitchDarkModeCubit,
                                  bool>(
                                builder: (context, isSwitched) {
                                  return Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      context
                                          .read<
                                              NotificationSwitchDarkModeCubit>()
                                          .toggleSwitch(value);
                                    },
                                    activeColor: appColors.pageBackground,
                                    activeTrackColor: appColors.seocndIconColor,
                                    inactiveThumbColor:
                                        appColors.pageBackground,
                                    inactiveTrackColor: appColors.secondText,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: 'Add a payment method',
                                    size: 18,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400),
                                Image.asset(
                                  Images.addapaymentmethod,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: 'Delete history',
                                    size: 18,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400),
                                Image.asset(
                                  Images.deletehistory,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: 'Language',
                                    size: 18,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400),
                                Image.asset(
                                  Images.language,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.secondText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: OnBoardingContainerMore(
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: 'Logout',
                                    size: 18,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400),
                                Image.asset(
                                  Images.logout,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
