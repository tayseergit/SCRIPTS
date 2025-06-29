import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/PaidCourseInfo/ReviewItem.dart' show Reviewitem;
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ReviewListView extends StatelessWidget {
  const ReviewListView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => SizedBox(height: 45.h),
      itemBuilder: (ctx, index) {
        return Reviewitem(); 
      },
    );
  }
}
