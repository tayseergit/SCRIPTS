import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_cubit.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_state.dart';
import 'package:lms/Module/CourseInfo/Cubit/Reveiw/review_cubit.dart';
import 'package:lms/Module/CourseInfo/View/Widget/Grid_course_info.dart';
import 'package:lms/Module/CourseInfo/View/Widget/loading.dart';
import 'package:lms/Module/TeacherProfile/teacherProfilePage.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';

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
    reviewCubit = ReviewCubit(courseId: widget.courseId);

    // Call first API
    courseInfoCubit.getCourseDescription();

    // Delay second API call
    Future.delayed(const Duration(milliseconds: 200), () {
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
            } else if (state is CouresUnUthunticatedError) {
              return NoAuth();
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
                          horizontal: 10.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: AuthText(
                                  text: courseInfoData.title,
                                  size: 20,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700,
                                  maxLines: 2,
                                ),
                              ),
                              OnBoardingContainer(
                                // width: 60,

                                height: 40,
                                color: appColors.border,
                                widget: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: AuthText(
                                    text: courseInfoData.level,
                                    size: 15,
                                    color:
                                        courseInfoData.level == 'intermediate'
                                            ? appColors.orang
                                            : courseInfoData.level == 'beginner'
                                                ? appColors.ok
                                                : appColors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                          BlocConsumer<ReviewCubit, ReviewState>(
                            listener: (context, reviewstate) {
                              if (reviewstate is AddReviewRequired) {
                                customSnackBar(
                                    context: context,
                                    success: 0,
                                    message: reviewstate.message);
                              }
                              if (reviewstate is AddReviewSuccess) {
                                customSnackBar(
                                    context: context,
                                    success: 1,
                                    message: "done");
                              }
                              if (reviewstate is DeleteReviewError ||
                                  reviewstate is ReviewError ||
                                  reviewstate is AddReviewError) {
                                customSnackBar(
                                    context: context,
                                    success: 0,
                                    message: "Error");
                              }
                            },
                            builder: (context, reviewstate) {
                              print(reviewstate);
                              final reviewCubit = context.read<ReviewCubit>();
                              if (reviewstate is ReviewLoading) {
                                return LoadingContainer(
                                  height: 70.h,
                                );
                              } else if (reviewstate is ReviewError) {
                                return Center(
                                  child: NoConnection(
                                    message: reviewstate.message,
                                  ),
                                );
                              }
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appColors.fieldBackground,
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
                                            rating: double.tryParse(
                                                    courseInfoData.rate) ??
                                                0.0,
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
                                        Container(
                                          height:
                                              reviewCubit.allReviews.isNotEmpty
                                                  ? 400.h
                                                  : null,
                                          child: ReviewListView(
                                              reviews: reviewCubit.allReviews),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.w,
                                            ),
                                            child: OnBoardingContainer(
                                              width: double.infinity,
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.w),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize
                                                              .min, // Allows vertical shrink/expansion
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  reviewCubit
                                                                      .addReviewController,
                                                              // Important for auto-growing
                                                              style: TextStyle(
                                                                color: appColors
                                                                    .mainText,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        left: 10
                                                                            .w),
                                                                hintText: reviewCubit
                                                                        .HasYourReview
                                                                    ? 'Edit Your Review'
                                                                    : "Add Review",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: appColors
                                                                      .secondText,
                                                                  fontSize:
                                                                      15.sp,
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  !reviewCubit
                                                                          .HasYourReview
                                                                      ? reviewCubit
                                                                          .postCourseReview()
                                                                      : reviewCubit
                                                                          .editCourseReview();
                                                                },
                                                                icon: reviewstate
                                                                        is AddReviewLoading
                                                                    ? Loading()
                                                                    : Icon(Icons
                                                                        .send),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.h),
                                                  RatingBar.builder(
                                                    itemSize: 20.w,
                                                    initialRating: 0,
                                                    minRating: 1,
                                                    direction: Axis.vertical,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      setState(() {
                                                        reviewCubit.userRating =
                                                            rating; // update state or controller
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )),
                                        SizedBox(height: 10.h),
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
                            text: "Mentor",
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
                          OnBoardingContainer(
                            height: 40.h,
                            width: double.infinity,
                            color: appColors.blackGreen,
                            radius: 20.r,
                            widget: Center(
                              child: AuthText(
                                text: 'Profile',
                                size: 13,
                                color: appColors.pageBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              pushTo(
                                  context: context,
                                  toPage: TeacherProfilePage());
                            },
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
