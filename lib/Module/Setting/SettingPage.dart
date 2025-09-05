import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/Module/Edit_profile/Cubit/edite_profile_cubit.dart';
import 'package:lms/Module/Edit_profile/View/Pages/edite_profile_page.dart';
import 'package:lms/Module/Localization/localization.dart';
import 'package:lms/Module/Setting/NotificationSwitchCubit.dart';
import 'package:lms/Module/Stripe/stripe_page.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/Module/payment/cubit/payment_state.dart';
import 'package:lms/Module/payment/cubit/puyment_cubit.dart';
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
        BlocProvider(
          create: (_) => PaymentCubit(),
        )
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OnBoardingContainerMore(
                        width: 330,
                        height: 60,
                        borderColor: appColors.blackGreen,
                        color: appColors.pageBackground,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: lang.push_notifications,
                                color: appColors.mainText,
                                size: 19,
                                fontWeight: FontWeight.w600,
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
                      SizedBox(
                        height: 30.h,
                      ),
                      OnBoardingContainerMore(
                        width: 330,
                        height: 60,
                        borderColor: appColors.blackGreen,
                        color: appColors.pageBackground,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: lang.dark_mode,
                                color: appColors.mainText,
                                size: 19,
                                fontWeight: FontWeight.w600,
                              ),
                              BlocBuilder<NotificationSwitchDarkModeCubit,
                                  bool>(
                                builder: (context, isSwitched) {
                                  return Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      print(value);
                                      // تغيير الثيم في ThemeCubit
                                      context.read<ThemeCubit>().toggleTheme();

                                      // تحديث حالة الـ Switch
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
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocConsumer<PaymentCubit, PaymentState>(
                        listener: (context, state) {
                          if (state is PaymentFailure) {
                            customSnackBar(
                                context: context,
                                success: 0,
                                message: lang.error_occurred);
                          } else if (state is PaymentSuccess) {
                            customSnackBar(
                                context: context,
                                success: 1,
                                message: lang.done);
                          } else if (state is PaymentAmountFailure) {
                            customSnackBar(
                                context: context,
                                success: 2,
                                message: lang.enter_valid_amount);
                          }
                        },
                        builder: (context, state) {
                          if (state is PaymentLoading) return Loading();
                          final cubit = context.read<PaymentCubit>();

                          return OnBoardingContainerMore(
                              onTap: () {
                                showAmountDialog(
                                  context,
                                );
                              },
                              width: 330,
                              height: 60,
                              color: appColors.pageBackground,
                              borderColor: appColors.blackGreen,
                              widget: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AuthText(
                                      text: lang.add_a_payment_method,
                                      color: appColors.mainText,
                                      size: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Image.asset(
                                      Images.addapaymentmethod,
                                      width: 35,
                                      height: 35,
                                    )
                                  ],
                                ),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      OnBoardingContainerMore(
                          onTap: () {
                            if (CacheHelper.getToken() == null) {
                              showNoAuthDialog(context);
                              return;
                            }
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
                          borderColor: appColors.blackGreen,
                          color: appColors.pageBackground,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                  text: lang.edit_profile,
                                  color: appColors.mainText,
                                  size: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                                Image.asset(
                                  Images.editProfile,
                                  width: 35,
                                  height: 35,
                                  color: appColors.mainIconColor,
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      OnBoardingContainerMore(
                          onTap: () {
                            context.read<LocaleCubit>().toggleLocale();
                          },
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          borderColor: appColors.blackGreen,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                  text: lang.change_language,
                                  color: appColors.mainText,
                                  size: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                                Image.asset(
                                  Images.language,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      OnBoardingContainerMore(
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
                                    BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        return TextButton(
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .logOut(context);
                                            print(state);
                                            if (state is UnAuth) {
                                              showNoAuthDialog(context);
                                            }
                                            if (state is LogOutError) {
                                              showNoAuthDialog(context);
                                            }

                                            Navigator.pop(context);

                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              pushAndRemoveUntilTo(
                                                  context: context,
                                                  toPage: Login());
                                            });
                                          },
                                          child: AuthText(
                                            text: lang.logout,
                                            color: appColors.red,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          width: 330,
                          height: 60,
                          color: appColors.pageBackground,
                          borderColor: appColors.blackGreen,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                  text: lang.logout,
                                  color: appColors.mainText,
                                  size: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                                Image.asset(
                                  Images.logout,
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
