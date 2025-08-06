import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/gridview_learn.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/main_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class LearnPathInfoPage extends StatelessWidget {
  final LearningPathInfoData learningPathInfoData;
  final LearnPathInfoCourseResponse learningPathInfoModel;
  const LearnPathInfoPage(
      {super.key,
      required this.learningPathInfoData,
      required this.learningPathInfoModel});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AboutthisPathCubit()),
        BlocProvider(create: (_) => TeacherCubit()),
        BlocProvider(create: (_) => LearnPathInfoCubit()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: (learningPathInfoData.image != null &&
                      learningPathInfoData.image.isNotEmpty)
                  ? Image.network(
                      learningPathInfoData.image,
                      width: double.infinity.w,
                      height: 250.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Images.noImage,
                          width: double.infinity.w,
                          height: 250.h,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      Images.noImage,
                      width: double.infinity.w,
                      height: 250.h,
                      fit: BoxFit.fill,
                    ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AuthText(
                        text: learningPathInfoData.title,
                        size: 20,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AuthText(
                        text:
                            '${learningPathInfoData.description} / ${learningPathInfoData.coursesCount} Courses',
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
                          text: '${learningPathInfoData.totalCoursesPrice}\$',
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
                                    text: learningPathInfoData.description,
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
                                      text: learningPathInfoData.teacherName,
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
                                    child: OnBoardingContainer(
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
                                            text: learningPathInfoData
                                                .teacherName,
                                            size: 20,
                                            color: appColors.mainText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          AuthText(
                                            text:
                                                learningPathInfoData.teacherBio,
                                            size: 8,
                                            color: appColors.secondText,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          AuthText(
                                            text:
                                                '${learningPathInfoData.teacherCoursesCount} Courses',
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
                                                color: appColors.border,
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
              child: Gridviewlearn(
                list: learningPathInfoModel.data,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: OnBoardingContainer(
                width: 200,
                height: 50,
                color: appColors.border,
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
