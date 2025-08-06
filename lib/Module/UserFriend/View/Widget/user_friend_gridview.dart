import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';
import 'package:lms/Module/UserFriend/View/Widget/user_friend_card.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class GridViewUserFriend extends StatelessWidget {
  final List<Friend> friend;
  const GridViewUserFriend({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    if (friend.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }
    return Container(
      height: 570.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 17.h),
        itemCount: friend.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.w,
            childAspectRatio: 0.95.r,
            mainAxisSpacing: 15.h,
            crossAxisSpacing: 15.w),
        itemBuilder: (ctx, index) {
          final friendList = friend[index];
          return Userfriendcard(
            friend: friendList,
          );
        },
      ),
    );
  }
}
