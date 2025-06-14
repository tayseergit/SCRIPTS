import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Project/RowProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/ReadMoreInlineText.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Projectcard extends StatelessWidget {
  const Projectcard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              border: Border.all(color: appColors.primary)),
          child: OnBordingContainer(
            width: double.infinity,
            height: double.infinity,
            color: appColors.fieldBackground,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.asset(
                          Images.courses,
                          width: 165,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.h, left: 3.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: appColors.ok,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: AuthText(
                              text: 'Wep',
                              color: appColors.pageBackground,
                              fontWeight: FontWeight.w900,
                              size: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Front end development',
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                      size: 13,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Description:',
                      size: 10,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ReadMoreInlineTextProject(
                      text:
                          'pr  oduc t.desc  ript ion d nsk djn  csk  jdncs  kjd sjdnclkms efjsdij sdcma;sldmc;aefwoefslkdmcsldc,a;sc,dlfkeirghudfnvsldc,a;s',
                      trimLength: 19,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      RowProjectCard(
                        text: 'React',
                        appColors: appColors,
                      ),
                      RowProjectCard(
                        text: 'React',
                        appColors: appColors,
                      ),
                      RowProjectCard(
                        text: 'React',
                        appColors: appColors,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 15,
                          child: Image.asset(
                            Images.logo,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      AuthText(
                        text: 'Ahmad',
                        size: 13,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(  
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          border: Border.all(color: appColors.secondText,width: 1.5)
                        ),
                        child: OnBordingContainer(width: 65,height: 15, color: appColors.pageBackground, widget:   AuthText(
                          text: 'GitHub',
                          size: 10,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                       OnBordingContainer(width: 65,height: 18, color: appColors.primary, widget:   AuthText(
                          text: 'View',
                          size: 10,
                          color: appColors.pageBackground,
                          fontWeight: FontWeight.w400,
                        ),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
