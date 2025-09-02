import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/StudentsProfile/View/Pages/student_profile_page.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
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
        child: InkWell(
          onTap: () {
            pushTo(
                context: context,
                toPage: StudentProfilePage(
                  userid: teacherModel.id,
                ));
          },
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
                    teacherModel.image != null
                        ? Image.network(
                            teacherModel.image!, // رابط افتراضي إذا كان null
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Images.noProfile, // صورة افتراضية محلية
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            Images.noProfile,
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
                              appColors.mainIconColor.withOpacity(0.2),
                              appColors.primary.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: appColors.blackGreen,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2, // الاسم يأخذ 3 أجزاء
                                child: Text(
                                  teacherModel.name,
                                  style: TextStyle(
                                    color: appColors.whiteText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w), // مسافة بين الاسم والزر
                              Flexible(
                                flex: 1, // أيقونة الإضافة تأخذ 0.25 من الصف
                                child: Builder(
                                  builder: (innerContext) => Container(
                                    decoration: BoxDecoration(
                                      // color: appColors.ok.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        final cubit = innerContext
                                            .read<ParticipantsCubit>();
                                        showDialog(
                                          context: innerContext,
                                          builder: (context) => AlertDialog(
                                            title: const Text('تأكيد الاضافة'),
                                            content: Text(
                                                'هل تريد اضافة ${teacherModel.name} الى قائمة الأصدقاء؟'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
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
                                                    message:
                                                        "Add Friend Successful",
                                                  );
                                                },
                                                child: const Text('اضافة',
                                                    style: TextStyle(
                                                        color: Colors.orange)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: appColors.ok,
                                        weight: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
