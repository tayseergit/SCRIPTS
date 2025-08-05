import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_cubit.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';

class Userfriendcard extends StatelessWidget {
  final Friend friend;
  const Userfriendcard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Center(
      child: Container(
        width: 180.w,
        height: 220.h,
        decoration: BoxDecoration(
          border: Border.all(color: appColors.primary, width: 0.8),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                Image.network(
                  friend.image ??
                      'https://www.radware.com/RadwareSite/MediaLibraries/WordPressImages/uploads/2020/06/anonymous-960x638.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          appColors.mainIconColor.withOpacity(0),
                          appColors.primary.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 110.w,
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: friend.level == "beginner"
                                  ? appColors.darkGreen
                                  : friend.level == "intermediate"
                                      ? appColors.orang
                                      : appColors.red,
                              width: 3),
                          left: BorderSide(
                              color: friend.level == "beginner"
                                  ? appColors.darkGreen
                                  : friend.level == "intermediate"
                                      ? appColors.orang
                                      : appColors.red,
                              width: 3),
                          right: BorderSide(
                              color: friend.level == "beginner"
                                  ? appColors.darkGreen
                                  : friend.level == "intermediate"
                                      ? appColors.orang
                                      : appColors.red,
                              width: 3),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14.r),
                          bottomRight: Radius.circular(14.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          friend.level,
                          style: TextStyle(
                            color: friend.level == "beginner"
                                ? appColors.darkGreen
                                : friend.level == "intermediate"
                                    ? appColors.orang
                                    : appColors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -15,
                  top: 50,
                  child: Builder(
                    builder: (innerContext) => IconButton(
                      onPressed: () {
                        final cubit = innerContext.read<UserFriendCubit>();
                        showDialog(
                          context: innerContext,
                          builder: (context) => AlertDialog(
                            title: const Text('تأكيد الحذف'),
                            content: Text(
                                'هل تريد حذف ${friend.name} من قائمة الأصدقاء؟'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('إلغاء'),
                              ),
                              TextButton(
                                onPressed: () {
                                  cubit.DeletFriend(friend);
                                  Navigator.pop(context);
                                  CustomSnackbar.show(
                                      context: context,
                                      duration: 5,
                                      fillColor: appColors.ok,
                                      message: "Remove Friend Successful",
                                    );
                                },
                                child: const Text('حذف',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: appColors.red,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                          color: appColors.mainText.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: appColors.primary)),
                      child: Text(
                        friend.name,
                        style: TextStyle(
                          color: appColors.pageBackground,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
