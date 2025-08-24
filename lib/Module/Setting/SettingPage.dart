import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/Module/Edit_profile/Cubit/edite_profile_cubit.dart';
import 'package:lms/Module/Edit_profile/View/Pages/edite_profile_page.dart';
import 'package:lms/Module/Localization/localization.dart';
import 'package:lms/Module/Setting/NotificationSwitchCubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NotificationSwitchPushNotificationsCubit()),
        BlocProvider(create: (context) => NotificationSwitchDarkModeCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: appColors.pageBackground,
          body: Stack(
            children: [
              ClipPath(
                clipper: TopWaveMoreClipper(),
                child: Container(
                  decoration: BoxDecoration(gradient: appColors.linear),
                  width: double.infinity,
                  height: 220.h,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Transform.rotate(
                  angle: 3.1416, // 180 degrees in radians (pi)

                  child: ClipPath(
                    clipper: TopWaveMoreClipper(),
                    child: Container(
                      decoration: BoxDecoration(gradient: appColors.linear),
                      width: double.infinity,
                      height: 220.h,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 130.h, horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                text: lang.push_notifications,
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
                                text: lang.dark_mode,
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
                                      context.read<ThemeCubit>().toggleTheme();
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
                                    text: lang.add_a_payment_method,
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => EditeProfileCubit(),
                                  child: EditProfile(),
                                ),
                              ),
                            );
                          },
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: lang.edit_profile,
                                    size: 18,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400),
                                Image.asset(
                                  Images.editProfile,
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
                          onTap: () {
                            context.read<LocaleCubit>().toggleLocale();
                          },
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: lang.change_language,
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
                          onTap: () async {
                            if (CacheHelper.getToken() == null)
                              showNoAuthDialog(context);
                            else {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: AuthText(
                                      maxLines: 2,
                                      size: 15,
                                      text: lang
                                          .Are_you_sure_you_want_to_log_out),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context), // cancel
                                      child: AuthText(
                                        text: lang.cancel,
                                        size: 15,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<AuthCubit>()
                                            .logOut(context);
                                        Navigator.pop(context);
                                      },
                                      child: AuthText(
                                        text: lang.logout,
                                        color: appColors.red,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text: lang.logout,
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
