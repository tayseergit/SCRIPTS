// lib/screens/video_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_state.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/GridViewComment.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/add_comment_field.dart';
import 'package:lms/Module/Course_content/View/Widget/content/ListViewCourses.dart';
import 'package:lms/Module/Course_content/View/Widget/content/GridviewVediocoursesShimmer.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseContentPage extends StatefulWidget {
  final int courseId;
  CourseContentPage({super.key, required this.courseId});

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  late VideoCubit videoCubit;
  late CourseContentCubit courseContentCubit;
  late CommentCubit commentCubit;

  @override
  void initState() {
    super.initState();
    videoCubit = VideoCubit(courseId: widget.courseId);
    commentCubit = CommentCubit(context: context);
    courseContentCubit = CourseContentCubit(courseId: widget.courseId)
      ..getCourseContent(context);
  }

  @override
  void dispose() {
    videoCubit.youtubeController?.pause();
    videoCubit.youtubeController?.dispose();
    videoCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    final lang = S.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: videoCubit),
        BlocProvider.value(value: courseContentCubit),
        BlocProvider.value(value: commentCubit),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: ListView(
          physics: videoCubit.youtubeController?.value.isFullScreen == true
              ? const NeverScrollableScrollPhysics() // تمنع التمرير في FullScreen
              : const BouncingScrollPhysics(),
          children: [
            Container(
              color: appColors.lightGray,
              width: double.infinity.w,
              child: BlocConsumer<VideoCubit, VideoState>(
                listener: (context, state) {
                  if (state is UnAuthVideo) showNoAuthDialog(context);
                },
                builder: (context, state) {
                  if (state is VideoLoadingYouTube) {
                    return SizedBox(
                      height: 275.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is VideoInitialYouTube) {
                    return SizedBox(
                      height: 275.h,
                      child: Center(
                        child: AuthText(
                          text: S.of(context).NoItem,
                          size: 20,
                        ),
                      ),
                    );
                  } else if (state is UnAuthVideo) {
                    return SizedBox(
                      height: 275.h,
                      child: Center(
                        child: AuthText(
                          text: S.of(context).NoItem,
                          size: 20,
                        ),
                      ),
                    );
                  } else if (state is VideoErrorYoutube) {
                    return SizedBox(
                      height: 275.h,
                      child: Center(child: AuthText(text: state.message)),
                    );
                  }

                  if (videoCubit.youtubeController == null)
                    return const SizedBox.shrink();

                  return YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      key: ValueKey(videoCubit.videoId),
                      controller: videoCubit.youtubeController!,
                      showVideoProgressIndicator: true,
                      onEnded: (metaData) {
                        videoCubit.sendProgressToApi(1.0);
                        videoCubit.youtubeController!.pause();
                        final allContents = courseContentCubit
                            .courseContentResponse!.data!.allContents;
                        courseContentCubit
                            .markVideoAsCompleted(videoCubit.videoId!);
                        // videoCubit.loadNextVideo(context, allContents);
                      },
                    ),
                    builder: (context, player) {
                      bool isFullScreen =
                          videoCubit.youtubeController!.value.isFullScreen;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: isFullScreen
                                ? null
                                : 200.h, // Small mode ارتفاع محدد
                            child: isFullScreen
                                ? player // FullScreen: YoutubePlayer يملأ الشاشة
                                : AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: player,
                                  ),
                          ),
                          if (!isFullScreen &&
                              videoCubit.videoDataResponse != null) ...[
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Row(
                                children: [
                                  AuthText(
                                    text: videoCubit
                                        .videoDataResponse!.data.order
                                        .toString()
                                        .padLeft(2, '0'),
                                    size: 24,
                                    color: appColors.secondText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: AuthText(
                                      text: videoCubit
                                          .videoDataResponse!.data.title,
                                      size: 24,
                                      color: appColors.mainText,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.w, top: 5.h),
                              child: Container(
                                width: 280.w,
                                child: AuthText(
                                  text: videoCubit
                                      .videoDataResponse!.data.description,
                                  size: 15,
                                  color: appColors.secondText,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// Comments Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: BlocConsumer<CommentCubit, CommentState>(
                listener: (context, commentState) {
                  if (commentState is CommentErrorState) {
                    customSnackBar(
                        context: context,
                        success: 0,
                        message: commentState.message);
                  }
                },
                builder: (context, commentState) {
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AuthText(
                              text: lang.comments,
                              size: 16,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w400,
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
                        if (commentCubit.isExpanded)
                          SizedBox(
                            height: 300.h,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: [
                                      const SizedBox(height: 5),
                                      GridViewComment(
                                          commentsCubit: commentCubit),
                                    ],
                                  ),
                                ),
                                CommentInputField(
                                  controller: commentCubit.addCommentController,
                                  onSend: () => commentState is ReplyModeState
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
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// Video Courses Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: BlocBuilder<CourseContentCubit, CourseContentState>(
                builder: (context, state) {
                  if (state is CourseContentLoading)
                    return GridviewVediocoursesShimmer();
                  if (state is CourseContentError)
                    return NoConnection(message: state.message);

                  final allContents = courseContentCubit
                      .courseContentResponse!.data!.allContents;
                  if (allContents.isEmpty) return NoItem();

                  return SizedBox(
                    height: 430.h,
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
