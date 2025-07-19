import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart' show OnBoardingContainer;
import 'package:lms/Module/mainWidget/authText.dart';

class RowProjectCard extends StatelessWidget {
  final String text;
  const RowProjectCard({
    super.key,
    required this.appColors,
    required this.text,
  });

  final ThemeState appColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: OnBoardingContainer(
            width: text.length * 9,
            height: 20,
            color: appColors.ok,
            widget: AuthText(
              text: text,
              size: 10,
              color: appColors.mainText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
      ],
    );
  }
}
