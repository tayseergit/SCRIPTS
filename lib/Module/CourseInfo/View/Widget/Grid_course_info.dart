import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/CourseInfo/Cubit/Reveiw/review_cubit.dart';
import 'package:lms/Module/CourseInfo/Model/Review/review_response.dart';
import 'package:lms/Module/CourseInfo/View/Widget/ReviewItem.dart'
    show Reviewitem;
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ReviewListView extends StatelessWidget {
  const ReviewListView({super.key, required this.reviews});
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final cubit = context.read<ReviewCubit>();

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent - 200) {
          cubit.getCourseReview();
        }
        return false;
      },
      child: ListView.separated(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => SizedBox(height: 1.h),
        itemBuilder: (ctx, index) {
          return Reviewitem(review: reviews[index]);
        },
      ),
    );
  }
}
