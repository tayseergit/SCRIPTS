import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/View/Widget/ProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewproject extends StatelessWidget {
  Gridviewproject({super.key, required this.projectModel});
  final List<ProjectModel> projectModel;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    ProjectCubit projectCubit = context.watch<ProjectCubit>();

    return SizedBox(
      height: 520 .h,
      child: Stack(
        children: [
          /// Fixed Background Image
          Positioned.fill(
            child: Image.asset(
              projectCubit.selectedTab > -1
                  ? "${Images.baseImages}${projectCubit.tagResponse!.tags[projectCubit.selectedTab].name.replaceAll(' ', '')}image.png"
                  : Images.webImage, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          /// Foreground GridView
          Container(
            color:
                appColors.pageBackground.withOpacity(0.85), // Optional overlay
            child: GridView.builder(
              padding: EdgeInsets.only(top: 17.h, bottom: 17.h),
              itemCount: projectModel.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.h,
                childAspectRatio: 175 / 255,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (ctx, index) {
                return Projectcard(
                  projectModel: projectModel[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
