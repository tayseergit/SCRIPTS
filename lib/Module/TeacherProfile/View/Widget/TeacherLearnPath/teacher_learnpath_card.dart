import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Contest/View/Widget/ReadMoreInlineText.dart';
import 'package:lms/Module/LearnPath/View/Widget/TopWaveClipper.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/View/Page/learn_path_info_page.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_learnpath_model.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class TeacherLearnpathCard extends StatelessWidget {
  final TeacherLearnpathModel learnPath;
  TeacherLearnpathCard({
    super.key,
    required this.learnPath,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeState appColors = context.watch<ThemeCubit>().state;
    final lang = S.of(context);

    return OnBoardingContainer(
      radius: 30,
      width: double.infinity,
      height: 400.h, // Increased height for bigger image + description
      color: appColors.lightGray.withOpacity(0.5),
      boarderColor: appColors.border,
      widget: Column(
        children: [
          // Top Image + Title
          Stack(
            children: [
              Container(
                height: 170.h, // Increased image height
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.r)),
                    gradient: appColors.linerImage.withOpacity(0.4)),
              ),
              if (learnPath.image != null && learnPath.image!.isNotEmpty)
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                  child: Image.network(
                    learnPath.image!,
                    height: 170.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.noImage,
                      height: 170.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: learnPath.totalCoursesPrice == 0
                        ? appColors.ok
                        : appColors.orang,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AuthText(
                    text: learnPath.totalCoursesPrice == 0
                        ? 'Free'
                        : "${learnPath.totalCoursesPrice}\$",
                    size: 12,
                    color: appColors.pageBackground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // TeachPositioned(
          AuthText(
            text: learnPath.title,
            size: 16,
            color: appColors.mainText,
            fontWeight: FontWeight.w700,
            maxLines: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                SizedBox(width: 10.w),
                AuthText(
                  text: learnPath.teacherName ?? 'Unknown',
                  size: 14,
                  color: appColors.mainText,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: ReadMoreInlineText(
              text: learnPath.description ,
              trimLength: 30,
            ),
          ),

          SizedBox(height: 10.h),

          // Courses Info + Rating
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.video_collection_sharp,
                        size: 18.h, color: appColors.primary),
                    SizedBox(width: 5.w),
                    AuthText(
                      text: "${learnPath.coursesCount} ${lang.courses}",
                      size: 14,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                RatingBarIndicator(
                  rating: learnPath.rate,
                  itemCount: 5,
                  itemSize: 18.h,
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // View Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: OnBoardingContainer(
              radius: 20,
              width: double.infinity,
              height: 40.h,
              color: appColors.primary,
              widget: Center(
                child: AuthText(
                  text: lang.view,
                  size: 14,
                  color: appColors.pageBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        final cubit = LearnPathInfoCubit();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
            child: Loading(),
          ),
        );

        try {
          await cubit.fetchAllLearnPathData(learnPath.id);

          // أغلق Dialog التحميل بعد اكتمال العملية
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

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
          } else if (cubit.state is LearnPathInfoError) {
            print(cubit.state);
            customSnackBar(
              context: context,
              success: 0,
              message: "cubit.state.masseg",
            );
          }
        } catch (e) {
          print("❌ Error during navigation: $e");
          customSnackBar(
            context: context,
            success: 0,
            message: lang.error_occurred,
          );
        }
      },
    );
  }
}
