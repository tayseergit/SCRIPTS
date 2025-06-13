import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/More/RowMore.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
        ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 127.h, right: 16.w, left: 16.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: appColors.primary, width: 2.5),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: OnBordingContainerMore(
                width: 343,
                height: 550,
                color: appColors.pageBackground,
                widget: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.w),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: appColors.fieldBackground,
                              widget: Rowmore(
                                text: 'Edit profile',
                                image: Images.editProfile,
                                onTapp: () {},
                                height: 25,
                                width: 25,  
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
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
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
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
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: 'Friend',
                                image: Images.friend,
                                onTapp: () {},
                                height: 25,
                                width: 25,  
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: 'Participants',
                                image: Images.participants,
                                onTapp: () {},
                                height: 25,
                                width: 25,  
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: appColors.pageBackground,
                              widget: Rowmore(
                                text: 'Teacher ',
                                image: Images.teacher,
                                onTapp: () {},
                                height: 25,
                                width: 25,  
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
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
                          SizedBox(height: 30.h,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
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
                          SizedBox(height: 30.h,),
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
    );
  }
}
