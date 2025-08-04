import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hint,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    Color darkText = appColors.mainText;
    Color accentColor = appColors.border;
    Color primaryColor = appColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            color: appColors.lightfieldBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: accentColor, width: 1),
          ),
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(20.r),
            // menuMaxHeight: 10,
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            dropdownColor: appColors.lightfieldBackground,
            hint: Text(hint, style: TextStyle(color: appColors.secondText)),
            style: TextStyle(color: darkText, fontSize: 14.sp),
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
