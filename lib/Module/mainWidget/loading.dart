import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  double height, width;

  Loading({this.height = 50, this.width = 50, super.key});
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return SizedBox(
      height: height.h,
      width: width.w,
      child: Transform.scale(
        scale: 1,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,

          /// Required, The loading type of the widget
          colors: [appColors.primary],

          /// Optional, The color collections
          strokeWidth: 3,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          // backgroundColor: appColors.pageBackground,

          /// Optional, Background of the widget
          // pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
        ),
      ),
    );
  }
}
