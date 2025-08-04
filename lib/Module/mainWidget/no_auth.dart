import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';

class NoAuthUser extends StatelessWidget {
  NoAuthUser({Key? key, this.height = 350, this.width = 250}) : super(key: key);
  double height, width;

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: height.h,
      width: width.w,
      child: Column(
        children: [
          Expanded(child: Image.asset(Images.noAtuh)),
          SizedBox(
            height: 20.h,
          ),
          OnBoardingContainer(
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  pushTo(context: context, toPage: Login());
                });
              },
              width: width,
              height: 50.h,
              color: appColors.primary,
              widget: AuthText(
                  text: S.of(context).Login_or_SignUp,
                  size: 14,
                  color: appColors.whiteText,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}

void showNoAuthDialog(BuildContext context) {
  showDialog(
    context: context,
    // Use a builder to access the context within the dialog
    builder: (BuildContext dialogContext) {
      final appColors = dialogContext.watch<ThemeCubit>().state;
      return Dialog(
        // The Dialog widget provides a floating, modal container
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r), // Apply rounded corners
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        child: NoAuthUser(
          height: 350,
          width: 250,
        ),
      );
    },
  );
}
