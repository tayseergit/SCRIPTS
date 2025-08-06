import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';

class ParticipantsCard extends StatelessWidget {
  final TeacherModel teacherModel;
  const ParticipantsCard({super.key, required this.teacherModel});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Center(
        child: Container(
          width: 180.w,
          height: 220.h,
          decoration: BoxDecoration(
            border: Border.all(color: appColors.primary, width: 0.8),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  Image.network(
                    teacherModel.image ??
                        'https://www.radware.com/RadwareSite/MediaLibraries/WordPressImages/uploads/2020/06/anonymous-960x638.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            appColors.mainIconColor.withOpacity(0),
                            appColors.primary.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 50,
                    child: Builder(
                      builder: (innerContext) => IconButton(
                        onPressed: () {
                          final cubit = innerContext.read<ParticipantsCubit>();
                          showDialog(
                            context: innerContext,
                            builder: (context) => AlertDialog(
                              title: const Text('تأكيد الاضافة'),
                              content: Text(
                                  'هل تريد اضافة ${teacherModel.name} الى قائمة الأصدقاء؟'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('إلغاء'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.addFriend(teacherModel);
                                    Navigator.pop(context);
                                    CustomSnackbar.show(
                                      context: context,
                                      duration: 5,
                                      fillColor: appColors.ok,
                                      message: "Add Friend Successful",
                                    );
                                  },
                                  child: const Text('اضافة',
                                      style: TextStyle(color: Colors.orange)),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: appColors.orang,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            color: appColors.mainText.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: appColors.primary)),
                        child: Text(
                          teacherModel.name,
                          style: TextStyle(
                            color: appColors.pageBackground,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
