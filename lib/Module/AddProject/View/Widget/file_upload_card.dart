import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Helper/image_picker.dart';
import 'package:lms/Module/AddProject/cubit/add_project_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';

class FileUploadCard extends StatefulWidget {
  final AddProjectCubit cubit;

  const FileUploadCard({super.key, required this.cubit});

  @override
  State<FileUploadCard> createState() => _FileUploadCardState();
}

class _FileUploadCardState extends State<FileUploadCard> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    Color darkText = appColors.secondText;
    Color accentColor = appColors.border;

    return InkWell(
      onTap: () async {
        final xfile = await ImageService().pickImageFromGallery();
        if (xfile != null) {
          final file = File(xfile.path);
          setState(() {
            pickedImage = file;
            widget.cubit.imageFile = file;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: appColors.whiteText,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: accentColor),
        ),
        child: Column(
          children: [
            pickedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      pickedImage!,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.image_outlined,
                    size: 40.sp,
                    color: darkText,
                  ),
            SizedBox(height: 10.h),
            Text(
              S.of(context).add_image,
              style: TextStyle(
                fontSize: 16.sp,
                color: darkText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
