import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_cubit.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_state.dart';
import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';
import 'package:lms/Module/UserFriend/View/Widget/user_friend_gridview.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class UserFriendPage extends StatelessWidget {
  // final FriendsResponse? friendsResponse;
  final Friend? friend;
  const UserFriendPage({
    super.key,
    this.friend,
    // this.friendsResponse
  });

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserFriendCubit()..fetchAllFriend(friend?.id ?? 0)),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<UserFriendCubit, UserFriendState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserFriendLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserFriendError) {
              return Center(child: NoConnection());
            } else if (state is UserFriendSuccess) {
              final friend = state.friendsResponse.friends;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  SizedBox(
                    height: 140.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OnBoardingContainer(
                      width: 130,
                      height: 50,
                      color: appColors.lihgtPrimer,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthText(
                            text: 'Friend:  ',
                            size: 16,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                          AuthText(
                            text: state.friendsResponse.total.toString(),
                            size: 16,
                            color: appColors.ok,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GridViewUserFriend(
                    friend: friend,
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
