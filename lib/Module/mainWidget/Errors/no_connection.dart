import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class NoConnection extends StatelessWidget {
  NoConnection(
      {super.key,
      this.height = 200,
      this.width = 200,
      this.message = "No Connection"});
  double height, width;
  String message;
  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    return Container(
      color: appColors.pageBackground,
      height: height.h,
      // width: width.w,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // المساحة المتاحة من الوالد
          final maxH = constraints.maxHeight;
          final maxW = constraints.maxWidth;

          // ‑‑ اختر نسبة للصورة (مثلاً 60٪ من أصغر بُعد)
          final imgSide = 0.6 * (maxH < maxW ? maxH : maxW);

          // ‑‑ فراغ رأسي بسيط أسفل الصورة
          final spacing = 0.05 * maxH;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ◀︎ الصورة
              SizedBox(
                height: imgSide,
                width: imgSide,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(Images.noConnection),
                ),
              ),

              SizedBox(height: spacing),

              // ◀︎ النص: نجعله يتقلص أو يتمدّد داخل عرض الوالد

              AuthText(
                text: message,
                size: 16.sp, // يمكن ضبطها بعامل نسبي أيضاً إن شئت
                color: appColors.secondText,
                fontWeight: FontWeight.w900,
              ),
            ],
          );
        },
      ),
    );
  }
}
