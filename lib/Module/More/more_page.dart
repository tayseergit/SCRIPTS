import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/ChatGpt/Cubit/chat_cubit.dart';
import 'package:lms/Module/ChatGpt/View/Pages/chat_page.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/main_cubit.dart';
import 'package:lms/Module/Notifications/Cubit/notification_cubit.dart';
import 'package:lms/Module/Notifications/View/Page/notifications_page.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/Participants/View/Page/Participants_page.dart';
import 'package:lms/Module/ResetPassword.dart/View/Widget/reset_dialog.dart';
import 'package:lms/Module/Setting/SettingPage.dart';
import 'package:lms/Module/Teacher/View/Page/teacher_Page.dart';
import 'package:lms/Module/TeacherProfile/View/Pages/teacher_profile_page.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_cubit.dart';
import 'package:lms/Module/UserFriend/View/Page/user_friend_page.dart'; 
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/StudentsProfile/View/Pages/student_profile_page.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/More/RowMore.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    var lang = S.of(context);
    return SafeArea(
      child: Scaffold(
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
            Positioned(
              top: 30.h,
              left: 16.w,
              child: AuthText(
                  text: S.of(context).read_more,
                  size: 30,
                  color: appColors.mainText,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 25.w),
                            OnBoardingContainerMore(
                              borderColor: appColors.blackGreen,
                              width: 333,
                              height: 60,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.profile,
                                image: Images.studentIcon,
                                onTapp: () {
                                  if (CacheHelper.getToken() != null) {
                                    if (CacheHelper.getData(key: "role") ==
                                        "teacher")
                                      pushTo(
                                          context: context,
                                          toPage: TeacherProfilePage());
                                    else
                                      pushTo(
                                          context: context,
                                          toPage: StudentProfilePage());
                                  } else {
                                    showNoAuthDialog(context);
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.change_password,
                                image: Images.changePassword,
                                onTapp: () {
                                  if (CacheHelper.getToken() != null) {
                                    showPasswordResetDialog(context);
                                  } else {
                                    showNoAuthDialog(context);
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.setting,
                                image: Images.setting,
                                onTapp: () {
                                  pushTo(
                                      context: context, toPage: Settingpage());
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.friends,
                                image: Images.friend,
                                onTapp: () {
                                  if (CacheHelper.getToken() == null) {
                                    showNoAuthDialog(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: UserFriendCubit(),
                                          child: UserFriendPage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.participants,
                                image: Images.participants,
                                onTapp: () {
                                  if (CacheHelper.getToken() == null) {
                                    showNoAuthDialog(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: ParticipantsCubit(),
                                          child: ParticipantsPage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.teachers,
                                image: Images.teacher,
                                onTapp: () {
                                  if (CacheHelper.getToken() == null) {
                                    showNoAuthDialog(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: TeacherCubit(),
                                          child: TeacherPage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.notifications,
                                image: Images.notification,
                                onTapp: () {
                                  if (CacheHelper.getToken() == null) {
                                    showNoAuthDialog(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: NotificationCubit(),
                                          child: NotificationPage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            OnBoardingContainerMore(
                              width: 330,
                              height: 60,
                              borderColor: appColors.blackGreen,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: lang.Chat,
                                image: 'assets/images/Chat.png',
                                onTapp: () {
                                  if (CacheHelper.getToken() == null||CacheHelper.getUserId()==null) {
                                    showNoAuthDialog(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: ChatCubit(),
                                          child: ChatPage(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
