import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart' show OnBordingContainer;
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
        OnBordingContainer(
          width: 35,
          height: 15,
          color: appColors.secondText,
          widget: AuthText(
            text: text,
            size: 7,
            color: appColors.mainText,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 5.w,),
      ],
    );
  }
}
