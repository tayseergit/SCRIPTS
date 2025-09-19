import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/StudentsProfile/View/Pages/student_profile_page.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_cubit.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';
import 'package:lms/generated/l10n.dart';

class Userfriendcard extends StatelessWidget {
  final Friend friend;
  const Userfriendcard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Center(
      child: InkWell(
        onTap: () {
          pushTo(
              context: context, toPage: StudentProfilePage(userid: friend.id));
        },
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
                  friend.image != null
                      ? Image.network(
                          friend.image!, // رابط افتراضي إذا كان null
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              Images.noProfile, // صورة افتراضية محلية
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          Images.noProfile,
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
                            friend.level! ?? "",
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
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: appColors.blackGreen.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2, // الاسم يأخذ 3 أجزاء
                              child: Text(
                                friend.name,
                                style: TextStyle(
                                  color: appColors.whiteText,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w), // مسافة بين الاسم والزر
                            Flexible(
                              flex: 1, // أيقونة الإضافة تأخذ 0.25 من الصف
                              child: Builder(
                                builder: (innerContext) => Container(
                                  decoration: BoxDecoration(
                                    // color: appColors.ok.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      final cubit =
                                          innerContext.read<UserFriendCubit>();
                                      showDialog(
                                        context: innerContext,
                                        builder: (context) => AlertDialog(
                                          title:   Text(S.of(context).delete_confirmation),
                                          content: Text(
                                              S.of(context).delete_message),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(S.of(context).cancel),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cubit.DeletFriend(friend);
                                                Navigator.pop(context);
                                                 
                                              },
                                              child:   Text(S.of(context).delete,
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: appColors.red,
                                      weight: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
