import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/CourseInfo/Cubit/CourseDiscription/course_info_cubit.dart';
import 'package:lms/Module/CourseInfo/View/Widget/dialog_Pay_confirm.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/Course_content/Model/ContentModel/course_content_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class Coursesvideocard extends StatelessWidget {
  // CourseInfoCubit
  Coursesvideocard(
      {super.key, required this.videoContentItem, required this.courseId});
  ContentItem videoContentItem;
  int courseId;
  @override
  Widget build(BuildContext context) {
    var videoCubit = context.read<VideoCubit>();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocBuilder<CourseContentCubit, CourseContentState>(
      builder: (context, state) {
        ThemeState appColors = context.watch<ThemeCubit>().state;

        if (state is CourseContentSuccess) {
          // نجيب الفيديو المحدث من Cubit
          final updatedItem = state.courseContentResponse.data!.allContents
              .firstWhere((c) => c.id == videoContentItem.id);

          int? selectedVideo = context.watch<VideoCubit>().state.selectedVideo;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.w),
            child: InkWell(
              onTap: () {
                if (updatedItem.isFree!) {
                  context.read<VideoCubit>().loadVideoFromApi(
                        context,
                        videoId: updatedItem.id,
                      );
                  context.read<CommentCubit>().videoId = updatedItem.id;
                  context.read<CommentCubit>().getAllComments();
                } else {
                  showConfirmDialog(
                    context: context,
                    title: S.of(context).payment_confirmation,
                    content:
                        "${S.of(context).buy_course_message} ${context.read<CourseInfoCubit>().courseDescriptionResponse!.data.price}  \$",
                    onConfirm: () async {
                      final courseInfoCubit = context.read<CourseInfoCubit>();
                      final courseContentCubit =
                          context.read<CourseContentCubit>();

                      courseInfoCubit.postEnrollCourse(courseId);

                      // After successful enrollment, refresh the course content
                      courseContentCubit.getCourseContent(context);
                    },
                  );
                }
              },
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  color: appColors.fieldBackground,
                  border: Border.all(
                      color: selectedVideo == updatedItem.id
                          ? appColors.ok
                          : appColors.border,
                      width: selectedVideo == updatedItem.id ? 3 : 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      AuthText(
                        text: updatedItem.order.toString().padLeft(2, '0'),
                        size: 25,
                        color: appColors.secondText,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: AuthText(
                          text: updatedItem.title,
                          size: 15,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (updatedItem.watched == true)
                        Icon(Icons.check_circle, color: appColors.ok),
                      if (updatedItem.type == "video")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            !updatedItem.isFree!
                                ? Icons.lock
                                : selectedVideo == updatedItem.id
                                    ? Icons.pause
                                    : Icons.play_circle_fill_outlined,
                            color: updatedItem.isFree!
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
        }

        return SizedBox.shrink();
      },
    );
  }
}
