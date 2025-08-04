import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
 import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ProjectLinksSection extends StatelessWidget {
  final TextEditingController gitHubController;
  final TextEditingController demoController;
  final TextEditingController steamController;

  const ProjectLinksSection({
    super.key,
    required this.gitHubController,
    required this.demoController,
    required this.steamController,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    Color darkText = appColors.mainText;
    Color accentColor = appColors.primary;
    Color primaryColor = appColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Links',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
        SizedBox(height: 8.h),
        _buildLinkTextField(
          controller: gitHubController,
          label: 'GitHub URL',
          hint: 'Enter GitHub link',
          icon: Icons.link,
          accentColor: accentColor,
          primaryColor: primaryColor,
        ),
        SizedBox(height: 10.h),
        _buildLinkTextField(
          controller: demoController,
          label: 'Demo URL',
          hint: 'Enter demo link',
          icon: Icons.play_circle_outline,
          accentColor: accentColor,
          primaryColor: primaryColor,
        ),
        SizedBox(height: 10.h),
        _buildLinkTextField(
          controller: steamController,
          label: 'Steam URL',
          hint: 'Enter Steam link',
          icon: Icons.gamepad,
          accentColor: accentColor,
          primaryColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildLinkTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color accentColor,
    required Color primaryColor,
  }) {
    const Color darkText = Color(0xFF333333);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: darkText.withOpacity(0.5)),
        labelText: label,
        labelStyle: TextStyle(color: darkText.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: darkText.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:   BorderSide(color: accentColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:   BorderSide(color: accentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:   BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}