import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Notifications/Cubit/notification_cubit.dart';
import 'package:lms/Module/Notifications/Cubit/notification_state.dart';
import 'package:lms/Module/Notifications/Model/notification_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class NotificationPage extends StatelessWidget {
  final NotificationData? notificationResponse;
  NotificationPage({super.key, this.notificationResponse});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => NotificationCubit()..fetchNotifications(),
      child: Scaffold(
        body: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is UnAuth) {
              showNoAuthDialog(context);
            }
          },
          builder: (context, state) {
            if (state is NotificationLoding) {
              return Center(
                child: SizedBox(
                  height: 80.h,
                  child: Loading(height: 50.h, width: 50.w),
                ),
              );
            } else if (state is NotificationError) {
              return Center(child: NoConnection());
            } else if (state is NotificationSuccess) {
              final notification = state.notificationResponse.data;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.notification),
                        opacity: 0.2,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: TopWaveMoreClipper(),
                    child: Container(
                      decoration: BoxDecoration(gradient: appColors.linear),
                      width: double.infinity,
                      height: 220.h,
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 16.w,
                    child: AuthText(
                      text: S.of(context).notifications,
                      size: 30,
                      color: appColors.mainText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 160.h),
                    child: GridView.builder(
                      padding: EdgeInsets.all(16.r),
                      itemCount: state.notificationResponse.data.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400.h,
                          childAspectRatio: 2.26.r,
                          mainAxisSpacing: 15.w,
                          crossAxisSpacing: 10.w),
                      itemBuilder: (context, index) {
                        final item = notification[index];
                        if (notification.isEmpty) {
                          return Center(
                            heightFactor: 1.5,
                            child: SizedBox(
                              height: 200.h,
                              child: NoItem(),
                            ),
                          );
                        }
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: appColors.pageBackground.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: appColors.primary,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: appColors.primary.withOpacity(0.2),
                                blurRadius: 10.r,
                                offset: Offset(0, 5),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                appColors.pageBackground,
                                appColors.lightGray
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthText(
                                text: item.title,
                                size: 14,
                                fontWeight: FontWeight.bold,
                                color: appColors.primary,
                              ),
                              SizedBox(height: 10.h),
                              AuthText(
                                text: item.message,
                                size: 12,
                                color: appColors.secondText,
                                fontWeight: FontWeight.w400,
                                maxLines: 2,
                              ),
                              SizedBox(height: 15.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: AuthText(
                                  text: item.createdAt.toString(),
                                  size: 10,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w400,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
