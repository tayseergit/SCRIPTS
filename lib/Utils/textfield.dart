 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Textfield extends StatelessWidget {
  Textfield({
    super.key,
    this.keyboardType = TextInputType.emailAddress,
    this.labelText,
    this.prefix,
    this.suffex,
    this.obscureText = false,
    required this.controller,
    this.textalign = TextAlign.left,
  });

  Widget? prefix;
  String? labelText;
  TextInputType? keyboardType;
  Widget? suffex;
  bool obscureText;
  TextEditingController controller;
  TextAlign textalign;

  @override
  Widget build(BuildContext context) {
        ThemeState appColors = context.watch<ThemeCubit>().state;

    return TextFormField(
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      cursorColor: appColors.secondText,
      cursorWidth: 5,
      textAlign: textalign,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffex,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        labelText: labelText,
      ),
      obscureText: obscureText,
    );
  }
}
