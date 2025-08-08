import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Course_content/Model/course_content_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Coursesvediocard extends StatelessWidget {
  Coursesvediocard(
      {super.key, required this.videoContentItem, required this.index});
  VideoItem videoContentItem;
  int index;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.w),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: appColors.fieldBackground,
            border: Border.all(color: appColors.border)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Row(
                children: [
                  AuthText(
                    text: (index).toString().padLeft(2, '0'),
                    size: 25,
                    color: appColors.secondText,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: AuthText(
                      text: videoContentItem.title,
                      size: 15,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  videoContentItem.watched!
                      ? Icon(
                          Icons.check_circle,
                          color: appColors.ok,
                        )
                      : Container()
                ],
              ),
              SizedBox(
                width: 1.w,
              ),
              IconButton(
                  onPressed: () {},
                  icon: videoContentItem.isFree
                      ? Icon(
                          Icons.play_circle_fill_outlined,
                          color: appColors.primary,
                          size: 50,
                        )
                      : Icon(
                          Icons.lock,
                          color: appColors.primary,
                          size: 50,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
