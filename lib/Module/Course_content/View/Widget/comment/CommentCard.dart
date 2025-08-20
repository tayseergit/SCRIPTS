import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/View/Widget/ReadMoreInlineText.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_state.dart';
import 'package:lms/Module/Course_content/Model/CommentModel/comment_response.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/deleting_icon.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';

class CommentCard extends StatefulWidget {
  final CommentModel commentModel;
  final bool isReplay;
  const CommentCard(
      {super.key, required this.commentModel, required this.isReplay});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showReplies = false;

  @override
  Widget build(BuildContext context) {
    final commentCubit = context.read<CommentCubit>();
    final appColors = context.watch<ThemeCubit>().state;
    final comment = widget.commentModel;
    final isReplay = widget.isReplay;
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        // Determine if the reply field should be visible
        final isReplying = state is ReplyModeState;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage:
                      comment.userImage != null && comment.userImage!.isNotEmpty
                          ? NetworkImage(comment.userImage!)
                          : AssetImage(Images.studentIcon) as ImageProvider,
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthText(
                        text: comment.userName,
                        size: 14,
                        color: appColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      ReadMoreInlineText(
                        text: comment.text,
                        trimLength: 50,
                      ),
                      // AuthText(
                      //   text: comment.text,
                      //   size: 14,
                      //   color: appColors.mainText,
                      //   fontWeight: FontWeight.w400,
                      // ),
                      Row(
                        children: [
                          IconButton(
                            iconSize: 22,
                            padding: EdgeInsets.zero,
                            onPressed: () => commentCubit.likeComment(comment),
                            icon: Icon(
                              comment.likedByMe
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: appColors.mainIconColor,
                            ),
                          ),
                          AuthText(
                            text: "${comment.likes}",
                            size: 14,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(width: 10.w),
                          isReplay
                              ? Container()
                              : comment.replies.isEmpty
                                  ? InkWell(
                                      onTap: () =>
                                          commentCubit.enterReplyMode(comment),
                                      child: AuthText(
                                        text: S.of(context).reply,
                                        size: 14,
                                        color: appColors.darkGreen,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () => setState(
                                          () => showReplies = !showReplies),
                                      child: AuthText(
                                        text: showReplies
                                            ? S.of(context).hide_replies
                                            : "${S.of(context).replies} (${comment.replies.length})",
                                        size: 14,
                                        color: appColors.darkGreen,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                          comment.isMine
                              ? IconButton(
                                  iconSize: 22,
                                  onPressed: () {
                                    isReplay
                                        ? commentCubit.deleteComment(
                                            comment, true)
                                        : commentCubit.deleteComment(
                                            comment, false);
                                  },
                                  icon: DeleteLoadingIcon(
                                      isLoading: commentCubit.state
                                              is DeleteCommentLoading
                                          ? true
                                          : false),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Display replies or reply field
            if (showReplies)
              Padding(
                  padding: EdgeInsets.only(left: 50.w, top: 5.h),
                  child: comment.replies.isNotEmpty
                      ? Column(
                          children: comment.replies
                              .map((reply) => CommentCard(
                                    commentModel: reply,
                                    isReplay: true,
                                  ))
                              .toList(),
                        )
                      : Container()),
            !isReplay
                ? Divider(
                    color: appColors.blackGreenDisable, // line color
                    thickness: 1, // line thickness
                    // optional: end padding from right
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
