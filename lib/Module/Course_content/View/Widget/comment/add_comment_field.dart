import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_state.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class CommentInputField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend;
  final String? hintText;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;

  const CommentInputField({
    super.key,
    this.controller,
    this.onSend,
    this.hintText,
    this.borderColor,
    this.textColor,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    var appColors = context.read<ThemeCubit>().state;

    var commentState = context.read<CommentCubit>().state;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? appColors.border,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: textColor ?? appColors.mainText,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: hintTextColor ?? appColors.secondText,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            hintText: hintText ?? S.of(context).add_comment,
            border: InputBorder.none,
            suffixIcon: BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: onSend,
                  icon: commentState is AddCommentLoading
                      ? Loading(
                          height: 30,
                          width: 30,
                        )
                      : Icon(Icons.send),
                  color: appColors.seocndIconColor,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
