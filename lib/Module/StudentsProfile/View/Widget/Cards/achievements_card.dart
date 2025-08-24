import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/achievement_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: appColors.mainText.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          /// Background image with fallback and loading
          Positioned.fill(
            child: achievement.image != null && achievement.image!.isNotEmpty
                ? Image.network(
                    achievement.image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Loading(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Images.noImage,
                        fit: BoxFit.contain,
                      );
                    },
                  )
                : Image.asset(
                    Images.noImage,
                    fit: BoxFit.contain,
                  ),
          ),

          /// Linear gradient overlay for text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: appColors.linerContainer.withOpacity(0.4),
              ),
            ),
          ),

          /// Text content at bottom
          Positioned(
            bottom: 12.h,
            left: 12.w,
            right: 12.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthText(
                  text: achievement.name,
                  color: appColors.mainText,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.h),
                AuthText(
                  text: achievement.achieveDate,
                  color: appColors.mainText,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
