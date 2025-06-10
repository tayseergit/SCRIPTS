import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool toggleObscure;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? fillColor;
  final double borderRadius;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.toggleObscure = false,
    this.fillColor,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.borderColor,
    this.textColor,
    this.hintColor,
    this.borderRadius = 12,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    final Color fillColor = widget.fillColor ?? theme.fieldBackground;
    final Color borderColor = widget.borderColor ?? theme.border;
    final Color textColor = widget.textColor ?? theme.mainText;
    final Color hintColor = widget.hintColor ?? theme.secondText;

    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscure,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          filled: true,
          fillColor: fillColor,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.toggleObscure
              ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                    color: hintColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                )
              : null,
          errorText: widget.errorText,
          hintStyle: TextStyle(color: hintColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.w),
          ),
        ),
      ),
    );
  }
}
