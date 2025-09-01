import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_cubit.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class EnrollWatchLaterButtons extends StatelessWidget {
  EnrollWatchLaterButtons({
    Key? key,
    required this.learningPathInfoModel,
  });

  LearningPathInfoData learningPathInfoModel;
  // LearnPathInfoCubit learnPathInfoCubit;
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: BlocConsumer<LearnPathInfoCubit, LearnPathInfoState>(
          listener: (context, state) {
            if (state is UpdateStatusSuccess || state is DeleteStatusSuccess) {
              customSnackBar(context: context, success: 1, message: lang.done);
            } else if (state is UpdateStatusError ||
                state is DeleteStatusError) {
              customSnackBar(
                  context: context, success: 0, message: lang.error_occurred);
            }
          },
          builder: (context, state) {
            print(state);

            if (state is LearnPathInfoLoading) {
              return Loading();
            }
            if (state is LearnPathInfoError) {
              return Container();
            }
            if (learningPathInfoModel == null ||
                learningPathInfoModel! == null) {
              return Loading(); // أو Container() إذا بتحب تخفيه
            }
            var learningPathInfoData = learningPathInfoModel!;
            var cubit = context.watch<LearnPathInfoCubit>();
            return Column(
              children: [
                AuthText(
                  text: "${lang.change_path_status}",
                  color: appColors.mainText,
                  size: 15,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: cubit.state is UpdateEnrollStatusLoading
                            ? Loading()
                            : OnBoardingContainer(
                                radius: 20.r,
                                // width: 160,
                                height: 50,
                                color: appColors.blackGreen,
                                widget: AuthText(
                                  text: lang.enroll,
                                  // size: 16,
                                  color: appColors.whiteText,
                                  fontWeight: FontWeight.w500,
                                ),
                                onTap: () {
                                  if (learningPathInfoData.status != "enroll") {
                                    cubit.updatePathStatus(context,
                                        learningPathInfoData.id, "enroll");
                                  }
                                })),
                    /////
                    /// watch later button
                    SizedBox(
                      width: 10.h,
                    ),
                    Expanded(
                        child: cubit.state is UpdateLaterStatusLoading
                            ? Loading()
                            : OnBoardingContainer(
                                // width: 120,
                                radius: 20.r,

                                height: 50,
                                color: appColors.blackGreen,
                                widget: AuthText(
                                  text: lang.watchLater,
                                  // size: 16,
                                  color: appColors.whiteText,
                                  fontWeight: FontWeight.w500,
                                ),
                                onTap: () {
                                  if (learningPathInfoData.status !=
                                      "watch_later") {
                                    cubit.updatePathStatus(context,
                                        learningPathInfoData.id, "watch_later");
                                  }
                                },
                              )),
                    SizedBox(
                      width: 10.h,
                    ),
                    Expanded(
                        child: cubit.state is DeleteStatusLoading
                            ? Loading()
                            : OnBoardingContainer(
                                // width: 120,
                                radius: 20.r,

                                height: 50,
                                color: appColors.blackGreen,
                                widget: AuthText(
                                  text: lang.remove_path_status,
                                  // size: 16,
                                  color: appColors.whiteText,
                                  fontWeight: FontWeight.w500,
                                ),
                                onTap: () {
                                  if (learningPathInfoData.status != null)
                                    cubit.deletePathStatus(
                                        context, learningPathInfoData.id);
                                },
                              ))
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
