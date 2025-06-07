import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/More/RowMore.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 127.h, right: 16.w, left: 16.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2.5),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: OnBordingContainerMore(
                width: 343,
                height: 550,
                color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
                                color: AppColors.gray,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: OnBordingContainerMore(
                              width: 330,
                              height: 60,
                              color: AppColors.white,
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
