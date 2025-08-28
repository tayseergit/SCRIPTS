import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/View/Widget/RowProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/ReadMoreInlineText.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Projectcard extends StatelessWidget {
  Projectcard({super.key, required this.projectModel});
  ProjectModel projectModel;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    ProjectCubit projectCubit = context.read<ProjectCubit>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
        border: Border.all(color: appColors.primary),
      ),
      child: OnBoardingContainer(
        radius: 30.r,
        width: double.infinity,
        height: double.infinity,
        color: appColors.pageBackground.withOpacity(0.3),
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AuthText(
                        text: projectModel.title,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                        size: 16,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReadMoreInlineTextProject(
                        text: projectModel.description,
                        trimLength: 15,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    if (projectModel.technologies != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 20.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: projectModel.technologies!.length,
                            itemBuilder: (context, index) {
                              return RowProjectCard(
                                appColors: appColors,
                                text: projectModel.technologies![index],
                              );
                            },
                          ),
                        ),
                      ),
                    if (projectModel.technologies == null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(height: 20.h, child: Container()),
                      ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: appColors.blackGreenDisable,
                          radius: 20.r,
                          child: Image.asset(
                            Images.studentImage,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: AuthText(
                            text: projectModel.userName,
                            size: 13,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: OnBoardingContainer(
                            height: 30,
                            color: appColors.blackGreen,
                            widget: AuthText(
                              text: 'GitHub',
                              size: 10,
                              color: appColors.pageBackground,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OnBoardingContainer(
                            onTap: () {
                            
                            },
                            height: 30,
                            color: appColors.primary,
                            widget: AuthText(
                              text: 'Demo',
                              size: 10,
                              color: appColors.pageBackground,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  // if (cubit.studentProfileModel.gitHubAccount !=
                              //     null) {
                              //   GlobalFunc.launchURL(
                              //       cubit.studentProfileModel.gitHubAccount!);
                              // }