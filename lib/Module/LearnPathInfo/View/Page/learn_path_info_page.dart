import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/enroll_watchLater_buttoms.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/gridview_learn_info.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/main_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';

class LearnPathInfoPage extends StatelessWidget {
  final LearningPathInfoData learningPathInfoData;
  final LearnPathInfoCourseResponse learningPathInfoModel;
  const LearnPathInfoPage(
      {super.key,
      required this.learningPathInfoData,
      required this.learningPathInfoModel});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AboutthisPathCubit()),
        BlocProvider(create: (_) => TeacherCubit()),
        BlocProvider(create: (_) => LearnPathInfoCubit()),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: appColors.pageBackground,
            body: Column(
              children: [
                Container(
                  height: 680.h,
                  child: SingleChildScrollView(
                    child: Column(
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
                        Padding(
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
                              Row(
                                children: [
                                  AuthText(
                                    text: '${S.of(context).total_points} : ',
                                    size: 15,
                                    color: appColors.secondText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  AuthText(
                                    text:
                                        '${learningPathInfoData.totalCoursesPrice}\$',
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AuthText(
                                                text: S
                                                    .of(context)
                                                    .learn_path_info,
                                                size: 16,
                                                color: appColors.mainText,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 0.5.h),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            AboutthisPathCubit>()
                                                        .toggleExpand();
                                                  },
                                                  child: Icon(
                                                    isExpanded
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (isExpanded) ...[
                                            AuthText(
                                              text: learningPathInfoData
                                                  .description,
                                              maxLines: 10,
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
                                                text: learningPathInfoData
                                                    .teacherName,
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
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (isExpanded) ...[
                                            Center(
                                              child: OnBoardingContainer(
                                                width: 170,
                                                // height: 209,
                                                color: appColors.pageBackground,
                                                widget: Column(
                                                  children: [
                                                    AuthText(
                                                      text: lang.mentor,
                                                      size: 20,
                                                      color: appColors.mainText,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          learningPathInfoData
                                                              .teacherImage, // network image
                                                          fit: BoxFit.cover,
                                                          width: 80,
                                                          height: 80,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            // fallback if network fails
                                                            return Image.asset(
                                                              Images
                                                                  .studentIcon,
                                                              fit: BoxFit.cover,
                                                              width: 80,
                                                              height: 80,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    AuthText(
                                                      text: learningPathInfoData
                                                          .teacherName,
                                                      size: 20,
                                                      color: appColors.mainText,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    AuthText(
                                                      text: learningPathInfoData
                                                          .teacherBio,
                                                      size: 12,
                                                      color:
                                                          appColors.secondText,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    AuthText(
                                                      text:
                                                          '${learningPathInfoData.teacherCoursesCount} ${lang.courses}',
                                                      size: 12,
                                                      color: appColors.mainText,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Container(
                                                      height: 40.h,
                                                      width: double.infinity.w,
                                                      decoration: BoxDecoration(
                                                          color: appColors
                                                              .blackGreen,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      30.r))),
                                                      child: Center(
                                                        child: AuthText(
                                                          text: lang.profile,
                                                          size: 15,
                                                          color: appColors
                                                              .whiteText,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GridviewlearnInfo(
                            list: learningPathInfoModel.data,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                EnrollWatchLaterButtons(
                  learningPathInfoData: learningPathInfoData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
