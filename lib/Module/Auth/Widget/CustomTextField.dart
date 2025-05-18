import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool toggleObscure;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color fillColor;
  final double borderRadius;
  final String? errorText; // ✅ تمت الإضافة هنا

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.toggleObscure = false,
    this.fillColor = Colors.grey,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.borderColor = const Color(0xFFCCCCCC),
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
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
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        filled: true,
        fillColor: widget.fillColor,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.toggleObscure
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
        errorText: widget.errorText, 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor, width: 2.5.w),
        ),
      ),
    );
  }
}

