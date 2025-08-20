import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/Course_content/Model/ContentModel/course_content_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Coursesvideocard extends StatelessWidget {
  Coursesvideocard(
      {super.key, required this.videoContentItem, required this.courseId});
  ContentItem videoContentItem;
  int courseId;
  @override
  Widget build(BuildContext context) {
    var videoCubit = context.read<VideoCubit>();
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        ThemeState appColors = context.watch<ThemeCubit>().state;

        int? selectedVideo =
            state.selectedVideo; // نقرأ selectedVideo من الحالة

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0.w),
          child: InkWell(
            onTap: () {
              context.read<VideoCubit>().loadVideoFromApi(
                    context,
                    videoId: videoContentItem.id,
                  );
              context.read<CommentCubit>().videoId = videoContentItem.id;
              context.read<CommentCubit>().getAllComments();
            },
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: appColors.fieldBackground,
                border: Border.all(
                    color: selectedVideo == videoContentItem.id
                        ? appColors.ok
                        : appColors.border,
                    width: selectedVideo == videoContentItem.id ? 3 : 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    AuthText(
                      text: videoContentItem.order.toString().padLeft(2, '0'),
                      size: 25,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AuthText(
                        text: videoContentItem.title,
                        size: 15,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (videoContentItem.watched == true)
                      Icon(Icons.check_circle, color: appColors.ok),
                    if (videoContentItem.type == "video")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          !videoContentItem.isFree!
                              ? Icons.lock
                              : selectedVideo == videoContentItem.id
                                  ? Icons.pause
                                  // : videoContentItem.completed
                                  //     ? Icons.done
                                      : Icons.play_circle_fill_outlined,
                          color: videoContentItem.isFree!
                              ? appColors.blackGreen
                              : appColors.blackGreenDisable,
                          size: 50.sp,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
