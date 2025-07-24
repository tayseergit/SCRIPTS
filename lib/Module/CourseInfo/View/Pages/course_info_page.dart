import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_cubit.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_state.dart';
import 'package:lms/Module/CourseInfo/Cubit/Reveiw/review_cubit.dart';
import 'package:lms/Module/CourseInfo/View/Widget/Grid_course_info.dart';
import 'package:lms/Module/CourseInfo/View/Widget/ReviewCubit.dart';
import 'package:lms/Module/CourseInfo/View/Widget/loading.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class CourseInfoPage extends StatefulWidget {
  const CourseInfoPage({super.key, required this.courseId});
  final int courseId;

  @override
  State<CourseInfoPage> createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  late CourseInfoCubit courseInfoCubit;
  late ReviewCubit reviewCubit;

  @override
  void initState() {
    super.initState();
    courseInfoCubit = CourseInfoCubit(courseId: widget.courseId);
    reviewCubit = ReviewCubit();

    // Call first API
    courseInfoCubit.getCourseDescription();

    // Delay second API call
    Future.delayed(const Duration(seconds: 1), () {
      reviewCubit.getCourseReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => courseInfoCubit),
        BlocProvider(create: (_) => reviewCubit),
      ],
      child: BlocConsumer<CourseInfoCubit, CourseInfoState>(
          listener: (context, state) {},
          builder: (context, state) {
            CourseInfoCubit courseInfoCubit = context.read<CourseInfoCubit>();
             print(state);
            if (state is CouresDescriptionLoading ||
                state is CourseInfoInitial) {
              return const CourseInfoLoadingShimmer();
            } else if (state is CouresDescriptionError) {
              return NoConnection();
            }
            var courseInfoData =
                courseInfoCubit.courseDescriptionResponse!.data;

            return Scaffold(
              backgroundColor: appColors.pageBackground,
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Image.asset(
                    Images.contest1,
                    width: double.infinity,
                    height: 300.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appColors.pageBackground,
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(30.r),
                      //   topRight: Radius.circular(30.r),
                      // ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: courseInfoData.title,
                                size: 20,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w700,
                                maxLines: 2,
                              ),
                              OnBoardingContainer(
                                width: 60,
                                height: 40,
                                color: appColors.border,
                                widget: AuthText(
                                  text: courseInfoData.level,
                                  size: 15,
                                  color: courseInfoData.level == 'expert'
                                      ? appColors.red
                                      : courseInfoData.level == 'beginer'
                                          ? appColors.ok
                                          : appColors.orang,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          AuthText(
                            text:
                                '//${courseInfoData.duration} hours / ${courseInfoData.numberOfVideos} videos / ${courseInfoData.numberOfParticipants} participant',
                            size: 12,
                            color: appColors.secondText,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 20.h),
                          BlocBuilder<ReviewCubit, ReviewState>(
                            builder: (context, reviewstate) {
                              print(reviewstate);
                              final reviewCubit = context.read<ReviewCubit>();
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appColors.lightGray,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: AuthText(
                                              text: 'Reviews',
                                              size: 14,
                                              color: appColors.mainText,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          RatingBarIndicator(
                                            rating: 2,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              reviewCubit.toggleExpand();
                                            },
                                            icon: Icon(
                                              reviewCubit.reviewExpanded
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      if (reviewCubit.reviewExpanded) ...[
                                        SizedBox(height: 10.h),
                                        ReviewListView(),
                                        SizedBox(height: 100.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15.w,
                                          ),
                                          child: OnBoardingContainer(
                                            width: double.infinity,
                                            height: 50,
                                            color: appColors.border,
                                            widget: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.r,
                                                  backgroundImage: AssetImage(
                                                    Images.courses,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            appColors.primary,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          30,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: TextField(
                                                        controller: reviewCubit
                                                            .addReviewController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                          color: appColors
                                                              .mainText,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Add Review',
                                                          hintStyle: TextStyle(
                                                              color: appColors
                                                                  .secondText),
                                                          border:
                                                              InputBorder.none,
                                                          suffixIcon:
                                                              IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.send,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                      ]
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AuthText(
                        text: 'About this course',
                        size: 16,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AuthText(
                      text: courseInfoData.description,
                      size: 14,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: OnBoardingContainer(
                      width: 170,
                      // height: 210,
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
                            // backgroundImage:
                            // NetworkImage(courseInfoData.teacherImage),
                          ),
                          AuthText(
                            text: courseInfoData.teacherName,
                            size: 20,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: 200.w,
                            child: AuthText(
                              text: courseInfoData.teacherBio,
                              size: 12,
                              color: appColors.secondText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AuthText(
                            text:
                                '${courseInfoData.numberOfTeacherCourses} Courses',
                            size: 12,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            height: 30.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appColors.blackGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r))),
                            child: Center(
                              child: AuthText(
                                text: 'Profile',
                                size: 13,
                                color: appColors.pageBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: appColors.pageBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        courseInfoData.status == null &&
                                courseInfoData.price == 0
                            ? OnBoardingContainer(
                                width: 160,
                                height: 50,
                                color: appColors.blackGreen,
                                widget: AuthText(
                                  text: 'Enroll',
                                  size: 16,
                                  color: appColors.pageBackground,
                                  fontWeight: FontWeight.w500,
                                ),
                                onTap: () {},
                              )
                            : courseInfoData.status == null &&
                                    courseInfoData.price != 0
                                ? OnBoardingContainer(
                                    width: 160,
                                    height: 50,
                                    color: appColors.blackGreen,
                                    widget: AuthText(
                                      text: 'Buy Now',
                                      size: 16,
                                      color: appColors.pageBackground,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onTap: () {},
                                  )
                                : OnBoardingContainer(
                                    width: 160,
                                    height: 50,
                                    color: appColors.blackGreen,
                                    widget: AuthText(
                                      text: 'Watch',
                                      size: 16,
                                      color: appColors.pageBackground,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onTap: () {},
                                  ),
                        SizedBox(
                          width: 15.w,
                        ),
                        courseInfoData.price != 0 &&
                                courseInfoData.status == null
                            ? AuthText(
                                text: '\$${courseInfoData.price}',
                                size: 20,
                                color: appColors.orang,
                                fontWeight: FontWeight.w700,
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
