import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/enroll_watchLater_buttoms.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/gridview_learn_info.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/main_cubit.dart';
import 'package:lms/Module/TeacherProfile/View/Pages/teacher_profile_page.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
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
        BlocProvider(
            create: (_) => LearnPathInfoCubit()
              ..fetchAllLearnPathData(learningPathInfoData.id)),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: BlocConsumer<LearnPathInfoCubit, LearnPathInfoState>(
            listener: (context, state) {
              // أي أكشن جانبي يجب أن يكون هنا
              if (state is UnAuthUser) {
                showNoAuthDialog(context); // هنا آمن لأنه بعد build
              } else if (state is UpdateStatusSuccess ||
                  state is DeleteStatusSuccess) {
                customSnackBar(
                    context: context, success: 1, message: S.of(context).done);
              } else if (state is UpdateStatusError ||
                  state is DeleteStatusError) {
                customSnackBar(
                    context: context,
                    success: 0,
                    message: S.of(context).error_occurred);
              }
            },
            builder: (context, state) {
              var cubit = context.read<LearnPathInfoCubit>();

              return Scaffold(
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
                                      learningPathInfoData.image!.isNotEmpty)
                                  ? Image.network(
                                      learningPathInfoData.image!,
                                      width: double.infinity.w,
                                      height: 250.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                                        text: '${S.of(context).total_price} : ',
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
                                        duration:
                                            const Duration(milliseconds: 300),
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
                                        duration:
                                            const Duration(milliseconds: 300),
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
                                                          ? Icons
                                                              .keyboard_arrow_up
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
                                                    color: appColors
                                                        .pageBackground,
                                                    widget: Column(
                                                      children: [
                                                        AuthText(
                                                          text: lang.mentor,
                                                          size: 20,
                                                          color: appColors
                                                              .mainText,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundColor: appColors
                                                              .lightfieldBackground,
                                                          radius: 40,
                                                          backgroundImage:
                                                              null, // نشيله ونستخدم child بدالها
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                              learningPathInfoData
                                                                      .teacherImage ??
                                                                  "", // إذا null يرجع ""
                                                              fit: BoxFit.cover,
                                                              width: 80,
                                                              height: 80,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  Images
                                                                      .noProfile, // صورتك الافتراضية
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 80,
                                                                  height: 80,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        AuthText(
                                                          text:
                                                              learningPathInfoData
                                                                  .teacherName,
                                                          size: 20,
                                                          color: appColors
                                                              .mainText,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        AuthText(
                                                          text:
                                                              learningPathInfoData
                                                                  .teacherBio,
                                                          size: 12,
                                                          color: appColors
                                                              .secondText,
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
                                                          color: appColors
                                                              .mainText,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            pushTo(
                                                                context:
                                                                    context,
                                                                toPage: TeacherProfilePage(
                                                                    teacherid:
                                                                        learningPathInfoData
                                                                            .teacherId));
                                                          },
                                                          child: Container(
                                                            height: 40.h,
                                                            width: double
                                                                .infinity.w,
                                                            decoration: BoxDecoration(
                                                                color: appColors
                                                                    .blackGreen,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30.r))),
                                                            child: Center(
                                                              child: AuthText(
                                                                text: lang
                                                                    .profile,
                                                                size: 15,
                                                                color: appColors
                                                                    .whiteText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
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
                    Container(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child:
                          BlocConsumer<LearnPathInfoCubit, LearnPathInfoState>(
                        listener: (context, state) {
                          if (state is UpdateStatusSuccess ||
                              state is DeleteStatusSuccess) {
                            customSnackBar(
                              context: context,
                              success: 1,
                              message: S.of(context).done,
                            );
                          } else if (state is UpdateStatusError ||
                              state is DeleteStatusError) {
                            customSnackBar(
                              context: context,
                              success: 0,
                              message: S.of(context).error_occurred,
                            );
                          }
                        },
                        builder: (context, state) {
                          var cubit = context.watch<LearnPathInfoCubit>();
                          if (state is LearnPathInfoInitial ||
                              state is LearnPathInfoLoading) {
                            return Loading();
                          }
                          if (state is LearnPathInfoError) {
                            return AuthText(
                              text: state.masseg,
                              color: appColors.mainText,
                            );
                          }

                          var data = cubit.learningPathInfoModel!.data;
                          return Column(
                            children: [
                              AuthText(
                                text: "${S.of(context).change_path_status}",
                                color: appColors.mainText,
                                size: 15,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Enroll Button
                                  Expanded(
                                    child: state is UpdateEnrollStatusLoading
                                        ? Loading()
                                        : OnBoardingContainer(
                                            radius: 20.r,
                                            height: 50,
                                            color: data.status == "enroll"
                                                ? appColors.secondText
                                                : appColors.blackGreen,
                                            widget: AuthText(
                                              text: S.of(context).enroll,
                                              color: appColors.whiteText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            onTap: () {
                                              if (data.status != "enroll") {
                                                cubit.updatePathStatus(
                                                    context, data.id, "enroll");
                                              }
                                            },
                                          ),
                                  ),

                                  SizedBox(width: 10.w),

                                  // Watch Later Button
                                  Expanded(
                                    child: state is UpdateLaterStatusLoading
                                        ? Loading()
                                        : OnBoardingContainer(
                                            radius: 20.r,
                                            height: 50,
                                            color: data.status == "watch_later"
                                                ? appColors.secondText
                                                : appColors.blackGreen,
                                            widget: AuthText(
                                              text: S.of(context).watchLater,
                                              color: appColors.whiteText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            onTap: () {
                                              if (data.status !=
                                                  "watch_later") {
                                                cubit.updatePathStatus(
                                                  context,
                                                  data.id,
                                                  "watch_later",
                                                );
                                              }
                                            },
                                          ),
                                  ),

                                  SizedBox(width: 10.w),

                                  // Remove Button
                                  Expanded(
                                    child: state is DeleteStatusLoading
                                        ? Loading()
                                        : OnBoardingContainer(
                                            radius: 20.r,
                                            height: 50,
                                            color: data.status != null
                                                ? appColors.blackGreen
                                                : appColors.secondText,
                                            widget: AuthText(
                                              text: S
                                                  .of(context)
                                                  .remove_path_status,
                                              color: appColors.whiteText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            onTap: () {
                                              if (data.status != null) {
                                                cubit.deletePathStatus(
                                                    context, data.id);
                                              }
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
