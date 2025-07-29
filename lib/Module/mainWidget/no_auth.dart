import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class NoAuth extends StatelessWidget {
  NoAuth({Key? key, this.height = 200, this.width = 200}) : super(key: key);
  double height, width;

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: height.h,
      width: width.w,
      child: Column(
        children: [
          Image.asset(Images.noAtuh),
          // AuthText(text: "Login or SignUp", size: 15, color: color, fontWeight: fontWeight)
          OnBoardingContainer(
              color: appColors.primary,
              widget: AuthText(
                  text: "Login or SignUp",
                  size: 10,
                  color: appColors.whiteText,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
