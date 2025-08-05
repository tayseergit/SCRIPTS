import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final List<String> selectedItems;
  final List<String> availableItems;
  final ValueChanged<String?> onChanged;

  const CustomMultiSelectDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedItems,
    required this.availableItems,
    required this.onChanged,
  });

  @override
  State<CustomMultiSelectDropdown> createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    Color darkText = appColors.mainText;
    Color accentColor = appColors.border;
    Color primaryColor = appColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ]),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: appColors.lightfieldBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: accentColor, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: appColors.lightfieldBackground,
              borderRadius: BorderRadius.circular(20.r),
              isExpanded: true,
              hint: Text(widget.hint,
                  style: TextStyle(color: appColors.secondText)),
              icon: Icon(Icons.arrow_drop_down, color: primaryColor),
              items: widget.availableItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Checkbox(
                        value: widget.selectedItems.contains(item),
                        onChanged: (bool? isChecked) {
                          if (isChecked!) {
                            widget.selectedItems.add(item);
                          } else {
                            widget.selectedItems.remove(item);
                          }
                          widget.onChanged(item); // Trigger parent setState
                          Navigator.pop(context); // Close the dropdown menu
                        },
                        activeColor: primaryColor,
                      ),
                      Text(item),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                // This onChanged is a placeholder to make the DropdownButton work
                // The actual logic is in the Checkbox
              },
              selectedItemBuilder: (BuildContext context) {
                return [
                  Text(
                    widget.selectedItems.isEmpty
                        ? widget.hint
                        : widget.selectedItems.join(', '),
                    style: TextStyle(
                        color: widget.selectedItems.isEmpty
                            ? darkText.withOpacity(0.5)
                            : darkText),
                  ),
                ];
              },
            ),
          ),
        ),
      ],
    );
  }
}
