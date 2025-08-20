// lib/screens/video_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_state.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/add_comment_field.dart';
import 'package:lms/Module/Course_content/View/Widget/content/GridviewVediocoursesShimmer.dart';
import 'package:lms/Module/Course_content/View/Widget/content/course_content_shminer.dart';
import 'package:lms/Module/Course_content/cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/View/Widget/content/ListViewCourses.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/GridViewComment.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseContentPage extends StatelessWidget {
  CourseContentPage({super.key, required this.courseId});
  int courseId;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    final TextEditingController controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VideoCubit(courseId: courseId)),
        BlocProvider(create: (_) => CommentCubit(context: context)),
        BlocProvider(
            create: (_) => CourseContentCubit(courseId: courseId)
              ..getCourseContent(context)),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: ListView(
          children: [
            Container(
                color: appColors.lightGray,
                width: double.infinity.w,
                height: 300.h,
                child: BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) {
                    print(state);
                    if (state is VideoLoadingYouTube) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is VideoInitialYouTube) {
                      return Center(
                          child: AuthText(
                        text: S.of(context).NoItem,
                        size: 20,
                      ));
                    } else if (state is VideoErrorYoutube) {
                      return Center(
                          child: AuthText(text: S.of(context).error_occurred));
                    }
                    final cubit = context.read<VideoCubit>();
                    return Column(
                      children: [
                        YoutubePlayer(
                        
                          controller: cubit.youtubeController!,
                          showVideoProgressIndicator: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.w),
                          child: Row(
                            children: [
                              AuthText(
                                text: (cubit.videoDataResponse!.data.order)
                                    .toString()
                                    .padLeft(2, '0'),
                                size: 24,
                                color: appColors.secondText,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                width: 200.w,
                                child: AuthText(
                                  text: cubit.videoDataResponse!.data.title,
                                  size: 24,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child: Container(
                            width: 280.w,
                            child: AuthText(
                              text: cubit.videoDataResponse!.data.description,
                              size: 15,
                              color: appColors.secondText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
            SizedBox(
              height: 12.h,
            ),

            ///   comments
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: BlocConsumer<CommentCubit, CommentState>(
                listener: (context, commentState) {},
                builder: (context, commentState) {
                  var commentCubit = context.read<CommentCubit>();
                  // if (commentState is CommentLoading )

                  return AnimatedSize(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColors.lightGray.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AuthText(
                                  text: lang.comments,
                                  size: 16,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  commentCubit.isExpanded
                                      ? commentCubit.toggleExpand()
                                      : commentCubit.toggleNotExpand();
                                },
                                icon: Icon(
                                  commentCubit.isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          if (commentCubit.isExpanded) ...[
                            Builder(
                              builder: (context) {
                                print(commentState);
                                if (commentState is CommentLoading) {
                                  return Loading();
                                }
                                if (commentState is CommentError) {
                                  return AuthText(text: commentState.message);
                                }
                                return SizedBox(
                                  height: 300.h,
                                  child: Column(
                                    children: [
                                      /// القائمة قابلة للتمرير
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            SizedBox(height: 5.h),
                                            GridViewComment(
                                                commentsCubit: commentCubit),
                                          ],
                                        ),
                                      ),

                                      /// التكست فيلد ثابتة تحت
                                      CommentInputField(
                                        controller:
                                            commentCubit.addCommentController,
                                        onSend: () => commentState
                                                is ReplyModeState
                                            ? commentCubit.addReply(
                                                commentState.parentComment.id)
                                            : commentCubit.addComment(),
                                        hintText: commentState is ReplyModeState
                                            ? lang.add_reply
                                            : lang.add_comment,
                                        borderColor: appColors.primary,
                                        textColor: appColors.mainText,
                                        hintTextColor: appColors.secondText,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: BlocConsumer<CourseContentCubit, CourseContentState>(
                listener: (context, state) {
                  CourseContentCubit courseContentCubit =
                      context.read<CourseContentCubit>();
                  if (state is CourseContentSuccess) {
                    print("ffffffffffffff");
                    print(courseContentCubit
                        .courseContentResponse!.data!.allContents.isNotEmpty);
                    if (courseContentCubit
                        .courseContentResponse!.data!.allContents.isNotEmpty) {
                      context.read<VideoCubit>().loadVideoFromApi(
                            context,
                            videoId: courseContentCubit
                                .courseContentResponse!.data!.allContents[0].id,
                          );
                    }
                  }
                },
                builder: (context, courseContentState) {
                  CourseContentCubit courseContentCubit =
                      context.read<CourseContentCubit>();
                  if (courseContentState is CourseContentLoading)
                    return GridviewVediocoursesShimmer();
                  else if (courseContentState is CourseContentError)
                    return NoConnection(message: courseContentState.message);
                  else if (courseContentCubit.courseContentResponse!.data!
                      .allContents.isEmpty) return NoItem();

                  return Container(
                    height: 400.h,
                    child: ListViewVediocourses(
                        courseData:
                            courseContentCubit.courseContentResponse!.data!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
