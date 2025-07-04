import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/PaidCourseInfo/GridView.dart';
import 'package:lms/Module/PaidCourseInfo/ReviewCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class PaidCourseInfoPage extends StatelessWidget {
  const PaidCourseInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController controller = TextEditingController();

    return BlocProvider(
      create: (_) => ReviewCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: appColors.pageBackground,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Image.asset(
                  Images.courses,
                  width: double.infinity,
                  height: 300.h,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            OnBoardingContainer(
                              width: 80,
                              height: 40,
                              color: appColors.border,
                              widget: AuthText(
                                text: 'Beginner',
                                size: 15,
                                color: appColors.ok,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        AuthText(
                          text:
                              '6h 14min / 24 Lessons / 3 tests / 24 participant',
                          size: 12,
                          color: appColors.secondText,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<ReviewCubit, bool>(
                          builder: (context, isExpanded) {
                            return AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: appColors.lightGray,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AuthText(
                                          text: 'Reviews',
                                          size: 16,
                                          color: appColors.mainText,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        RatingBarIndicator(
                                          rating: 3.5,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              AssetImage(Images.courses),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<ReviewCubit>()
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
                                                      color: appColors.primary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        30,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                                                    child: TextField(
                                                      controller: controller,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      style: TextStyle(
                                                        color: appColors.mainText,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: 'Add Review',
                                                        hintStyle: TextStyle(
                                                            color: appColors
                                                                .secondText),
                                                        border: InputBorder.none,
                                                        suffixIcon: IconButton(
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
                    text:
                        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, ',
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
                          backgroundImage: AssetImage(Images.courses),
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
                              color: appColors.blackGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
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
                SizedBox(
                  height: 15.h,
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
                      OnBoardingContainer(
                        width: 160,
                        height: 50,
                        color: appColors.blackGreen,
                        widget: AuthText(
                          text: 'Buy Now',
                          size: 16,
                          color: appColors.pageBackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      AuthText(
                        text: '\$74.00',
                        size: 20,
                        color: appColors.orang,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
