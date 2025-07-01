import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/LearnPathInfo/GridViewLearn.dart';
import 'package:lms/Module/LearnPathInfo/cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class LearnPathInfoPage extends StatelessWidget {
  const LearnPathInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AboutthisPathCubit()),
        BlocProvider(create: (_) => TeacherCubit()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: ListView(
          children: [
            Image.asset(
              Images.courses,
              width: double.infinity,
              height: 250.h,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColors.pageBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 25.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthText(
                          text: 'Product Design v1.0',
                          size: 20,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                        OnBordingContainer(
                          width: 75,
                          height: 30,
                          color: appColors.fieldBackground,
                          widget: AuthText(
                            text: 'Beginner',
                            size: 15,
                            color: appColors.ok,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AuthText(
                        text: '6h 14min / 24 Courses',
                        size: 12,
                        color: appColors.secondText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        AuthText(
                          text: 'Total Price : ',
                          size: 15,
                          color: appColors.secondText,
                          fontWeight: FontWeight.w700,
                        ),
                        AuthText(
                          text: '85\$',
                          size: 15,
                          color: appColors.orang,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<AboutthisPathCubit, bool>(
                      builder: (context, isExpanded) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: Container(
                            width: double.infinity,
                            color: appColors.pageBackground,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AuthText(
                                      text: 'About this Path',
                                      size: 16,
                                      color: appColors.mainText,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 0.5.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<AboutthisPathCubit>()
                                              .toggleExpand();
                                        },
                                        child: Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (isExpanded) ...[
                                  AuthText(
                                    text:
                                        'textflgbjslkmfdvlkmadkfvmadlfvmakdrkfald;mvaldfadfsdfkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk',
                                    size: 15,
                                    color: appColors.secondText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<TeacherCubit, bool>(
                      builder: (context, isExpanded) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: Container(
                            width: double.infinity,
                            color: appColors.pageBackground,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AuthText(
                                      text: 'Tayseer Matar',
                                      size: 16,
                                      color: appColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<TeacherCubit>()
                                            .toggleExpand();
                                      },
                                      icon: Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                if (isExpanded) ...[
                                  Center(
                                    child: OnBordingContainer(
                                      width: 170,
                                      height: 209,
                                      color: appColors.pageBackground,
                                      widget: Column(
                                        children: [
                                          AuthText(
                                            text: 'Mentor',
                                            size: 20,
                                            color: appColors.mainText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                AssetImage(Images.courses),
                                          ),
                                          AuthText(
                                            text: 'Steve M',
                                            size: 20,
                                            color: appColors.mainText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          AuthText(
                                            text: 'Full-stack Developer',
                                            size: 8,
                                            color: appColors.secondText,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          AuthText(
                                            text: '22 Courses',
                                            size: 10,
                                            color: appColors.mainText,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            height: 20.h,
                                            width: double.infinity.w,
                                            decoration: BoxDecoration(
                                                color: appColors.main2,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Center(
                                              child: AuthText(
                                                text: 'Profile',
                                                size: 10,
                                                color: appColors.pageBackground,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Gridviewlearn(),
            ),
             SizedBox(height: 10.h),
            Center(
              child: OnBordingContainer(
                width: 200,
                height: 50,
                color: appColors.main2,
                widget: AuthText(
                  text: 'Enroll',
                  size: 16,
                  color: appColors.pageBackground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
