import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_cubit.dart';
import 'package:lms/Module/Course_content/Model/CommentModel/comment_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Course_content/View/Widget/comment/CommentCard.dart';

class GridViewComment extends StatelessWidget {
  GridViewComment({super.key, required this.commentsCubit});
  CommentCubit commentsCubit;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentsCubit.allComments.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (ctx, index) {
        return CommentCard(
          commentModel: commentsCubit.allComments[index],isReplay: false,
        );
      },
    );
  }
}
