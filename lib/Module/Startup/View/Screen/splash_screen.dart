import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/NavigationBarWidged/navigationBarWidget.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _textTimer;
  String fullText = "SCRIPTS";
  String currentText = "";
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
    _navigateAfterDelay();
  }

  void _startTypingAnimation() {
    _textTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (currentIndex < fullText.length) {
        setState(() {
          currentText += fullText[currentIndex];
          currentIndex++;
        });
      } else {
        _textTimer?.cancel();
      }
    });
  }

  void _navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    final token = CacheHelper.getData(key: "token");

    if (!mounted) return; // Prevent navigation if widget is disposed

    // if (token == null) {
    pushAndRemoveUntilTo(context: context, toPage: Login());
    // } else {
    // pushAndRemoveUntilTo(
    // context: context, toPage: const NavigationBarwidget());
    // }
  }

  @override
  void dispose() {
    _textTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 200.w,
            ),
            SizedBox(height: 20.h),
            Text(
              currentText,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: appColors.primary,
                letterSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
