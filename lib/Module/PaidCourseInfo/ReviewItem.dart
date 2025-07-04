import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Reviewitem extends StatelessWidget {
  const Reviewitem({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundImage: AssetImage(Images.courses),
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AuthText(
                  text: 'Poetri Lazuzardi',
                  size: 10,
                  color: appColors.ok,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthText(
                  text: 'Ultrices vitae auctor eu augue. Tincidunt id aliquet risus.',
                  size: 10,
                  color: appColors.mainText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
