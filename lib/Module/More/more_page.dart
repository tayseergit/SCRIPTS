import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/More/TopWave_more_Clipper.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/Participants/View/Page/Participants_page.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_cubit.dart';
import 'package:lms/Module/Teacher/View/Page/teacher_Page.dart';
import 'package:lms/Module/TeacherProfile/View/Pages/teacher_profile_page.dart';
import 'package:lms/Module/TeacherProfile/cubit/TeacherProfile/teacher_profile_cubit.dart';
import 'package:lms/Module/UserFriend/Cubit/user_friend_cubit.dart';
import 'package:lms/Module/UserFriend/View/Page/user_friend_page.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/More/RowMore.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
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
                  text: "Tayseer Matar",
                  size: 30,
                  color: appColors.mainText,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 127.h, right: 16.w, left: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: appColors.primary, width: 2.5),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: OnBoardingContainerMore(
                  width: 343,
                  height: 580,
                  color: appColors.pageBackground,
                  widget: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.w),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: appColors.secondText,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Edit profile',
                                  image: Images.editProfile,
                                  onTapp: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: TeacherProfileCubit(),
                                          child: TeacherProfilePage(),
                                        ),
                                      ),
                                    );
                                  },
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Change Password',
                                  image: Images.changePassword,
                                  onTapp: () {},
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Setting',
                                  image: Images.setting,
                                  onTapp: () {},
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Friend',
                                  image: Images.friend,
                                  onTapp: () {
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
                                  },
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Participants',
                                  image: Images.participants,
                                onTapp: () {
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
                                  },
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'Teacher ',
                                  image: Images.teacher,
                                   onTapp: () {
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
                                  },
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'All Projects',
                                  image: Images.allProject,
                                  onTapp: () {},
                                  height: 25,
                                  width: 25,
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
                                  Radius.circular(30),
                                ),
                              ),
                              child: OnBoardingContainerMore(
                                width: 330,
                                height: 60,
                                color: appColors.pageBackground,
                                widget: Rowmore(
                                  text: 'My Project',
                                  image: Images.myProject,
                                  onTapp: () {},
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
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
