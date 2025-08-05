import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/LearnPath/Model/learn_path_reaponse.dart';
import 'package:lms/Module/LearnPath/View/Widget/TopWaveClipper.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/View/Page/learn_path_info_page.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Learnpathcard extends StatelessWidget {
  Learnpathcard({super.key, required this.learnPath});
  LearningPath learnPath;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColors.border, width: 3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBoardingContainer(
          width: 180.w,
          height: 10.h,
          color: appColors.pageBackground,
          widget: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 70.h,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: TopWaveClipper(),
                      child: Container(
                        height: 100.h,
                        width: double.infinity.w,
                        color: appColors.lihgtPrimer,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          height: 60.h,
                          width: 225.w,
                          child: Center(
                            child: AuthText(
                                text: learnPath.title,
                                size: 14,
                                color: appColors.mainText,
                                maxLines: 2,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: OnBoardingContainer(
                          width: 60,
                          height: 40,
                          color: learnPath.totalCoursesPrice == 0
                              ? appColors.ok
                              : appColors.orang,
                          widget: AuthText(
                            text: learnPath.totalCoursesPrice == 0
                                ? 'Free'
                                : "${learnPath.totalCoursesPrice} \$",
                            size: 12,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 200.h,
                  child:
                      (learnPath.image == null && learnPath.image!.isNotEmpty)
                          ? Image.network(
                              learnPath.image!,
                              width: double.infinity,
                              height: 100.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  Images.noImage,
                                  width: double.infinity,
                                  height: 100.h,
                                  fit: BoxFit.contain,
                                );
                              },
                            )
                          : Image.asset(
                              Images.noImage,
                              width: double.infinity,
                              height: 100.h,
                              fit: BoxFit.fill,
                            ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OnBoardingContainer(
                        radius: 20,
                        width: 130,
                        height: 40,
                        color: appColors.primary,
                        widget: AuthText(
                          text: 'View Path',
                          size: 16,
                          color: appColors.pageBackground,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      OnBoardingContainer(
                        radius: 20,
                        width: 100,
                        height: 40,
                        color: appColors.purple,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                Images.courses2,
                                width: 18.w,
                                height: 18.h,
                                color: appColors.mainText,
                              ),
                              AuthText(
                                text: '${learnPath.coursesCount} courses',
                                color: appColors.mainText,
                                fontWeight: FontWeight.w600,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: learnPath.rate,
                        itemCount: 5,
                        itemSize: 15.0, // star size
                        direction: Axis.horizontal,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          onTap: () async {
            print("🔄 Fetching path info and courses for id: ${learnPath.id}");

            final cubit = LearnPathInfoCubit();

            try {
              await cubit.fetchAllLearnPathData(learnPath.id);

              if (cubit.state is LearnPathAllDataSuccess) {
                final data = cubit.state as LearnPathAllDataSuccess;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LearnPathInfoPage(
                      learningPathInfoData: data.info.data,
                      learningPathInfoModel: data.courses,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('❌ Failed to load path data')),
                );
              }
            } catch (e) {
              print("❌ Error during navigation: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ Unexpected error occurred')),
              );
            }
          }),
    );
  }
}
