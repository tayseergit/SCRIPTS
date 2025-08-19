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
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';
import 'package:lms/generated/l10n.dart';

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
              return Center(
                child: SizedBox(
                  height: 80.h,
                  child: Loading(height: 50.h, width: 50.w),
                ),
              );
            } else if (state is UserFriendError) {
              return Center(child: NoConnection());
            } else if (state is UserFriendSuccess) {
              final friend = state.friendsResponse.friends;
              return Stack(
                children: [
                  ClipPath(
                    clipper: TopWaveMoreClipper(),
                    child: Container(
                      decoration: BoxDecoration(gradient: appColors.linear),
                      width: double.infinity,
                      height: 250.h,
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 16.w,
                    child: AuthText(
                      text: S.of(context).friends,
                      size: 30,
                      color: appColors.mainText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView(
                    padding: EdgeInsets.only(top: 20.w),
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
                                text: '${S.of(context).friends}: ',
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
