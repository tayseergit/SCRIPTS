import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customtextfieldsearsh extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color fillColor;
  final Color hintColors;
  final double borderRadius;
  final double hintFontSize;
  final String? errorText;
  final String? hintText;
  final FontWeight? hintFontWeight;

  const Customtextfieldsearsh({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.fillColor = Colors.grey,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.borderColor = const Color(0xFFCCCCCC),
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.borderRadius = 12,
    this.errorText,
    this.hintText,
    this.hintColors = Colors.black,
    this.hintFontSize = 3,
    this.hintFontWeight,
  });

  @override
  State<Customtextfieldsearsh> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<Customtextfieldsearsh> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: widget.hintFontSize,
          fontWeight: widget.hintFontWeight,
          color: widget.hintColor,
        ),
        filled: true,
        fillColor: widget.fillColor,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,

        errorText: widget.errorText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor, width: 3.w),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor, width: 2.5.w),
        ),
      ),
    );
  }
}
