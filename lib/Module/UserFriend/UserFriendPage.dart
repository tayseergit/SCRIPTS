import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Courses/customTextFieldSearsh.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/UserFriend/gridViewUsreFriend.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class UserFriendPage extends StatelessWidget {
  const UserFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(
            height: 110.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OnBordingContainer(
              width: 130,
              height: 50,
              color: appColors.lihgtPrimer,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthText(
                    text: 'Friend:',
                    size: 16,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w400,
                  ),
                  AuthText(
                    text: '45',
                    size: 16,
                    color: appColors.ok,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:  EdgeInsets.only(left: 150),
              child: Customtextfieldsearsh(
                borderRadius: 6,
                controller: search,
                borderColor: appColors.primary,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 30,
                  color: appColors.iconSearsh,
                ),
                suffixIcon: Image.asset(
                  Images.filter,
                  width: 17.w,
                  height: 17.h,
                  color: appColors.iconSearsh,
                ),
                hintText: 'which friend?',
                hintFontSize: 13.sp,
                hintFontWeight: FontWeight.w600,
                fillColor: appColors.pageBackground,
              ),
            ),
          ),
          SizedBox(height: 18.h,),
          GridViewUserFriend(),
        ],
      ),
    );
  }
}
