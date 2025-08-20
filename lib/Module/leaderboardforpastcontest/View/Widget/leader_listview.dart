import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Model/leader_board_for_past_contest_model.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/gridview_caer_leader.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/listview_container.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/card.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/generated/l10n.dart';

class LeaderListView extends StatelessWidget {
  final QuizResultModel quizResultModel;
  const LeaderListView({super.key, required this.quizResultModel});

  @override
  Widget build(BuildContext context) {
    print('🟢 [L] بناء LeaderListView');
    print('🟢 [M] بيانات quizResultModel: ${quizResultModel.toJson()}');
    print('🟢 [N] عدد الطلاب: ${quizResultModel.students.length}');
    ThemeState appColors = context.watch<ThemeCubit>().state;
    if (quizResultModel.students.length < 3) {
      print('🟢 [P] عدد الطلاب أقل من 3، عرض GridviewCaerLeader');
      return Column(
        children: [
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.only(right: 34.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: OnBoardingContainer(
                width: 110,
                height: 30,
                color: appColors.border,
                widget: (quizResultModel.yourOrder == null || quizResultModel.yourOrder == 0)
                    ? AuthText(
                        text: S.of(context).leaderbord,
                        size: 15,
                        color: appColors.red,
                        fontWeight: FontWeight.w400,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthText(
                            text: 'You: ',
                            size: 15,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                          AuthText(
                            text: quizResultModel.yourOrder.toString(),
                            size: 15,
                            color: appColors.ok,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          GridviewCaerLeader(
            students: quizResultModel.students,
            questionCount: quizResultModel.questionCount,
          )
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 34.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: OnBoardingContainer(
              width: 70,
              height: 30,
              color: appColors.border,
              widget: (quizResultModel.yourOrder == null || quizResultModel.yourOrder == 0)
                  ? AuthText(
                      text: S.of(context).leaderbord,
                      size: 15,
                      color: appColors.red,
                      fontWeight: FontWeight.w400,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthText(
                          text: 'You: ',
                          size: 15,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                        AuthText(
                          text: quizResultModel.yourOrder.toString(),
                          size: 15,
                          color: appColors.ok,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListViewContainer(
              name: quizResultModel.students[1].name,
              score: quizResultModel.students[1].gainedPoints.toString(),
              rank: quizResultModel.students[1].rank.toString(),
              rankColor: appColors.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r)),
              image: (quizResultModel.students[1].image != null &&
                      quizResultModel.students[1].image.isNotEmpty)
                  ? Image.network(
                      quizResultModel.students[1].image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Images.noImage,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      Images.noImage,
                      fit: BoxFit.contain,
                    ),
              height: 150.h,
              border: Border(
                bottom: BorderSide(color: appColors.primary, width: 4),
                left: BorderSide(color: appColors.primary, width: 4),
              ),
            ),
            ListViewContainer(
              name: quizResultModel.students[0].name,
              score: quizResultModel.students[0].gainedPoints.toString(),
              rank: quizResultModel.students[0].rank.toString(),
              rankColor: appColors.orang,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r)),
              image: (quizResultModel.students[0].image != null &&
                      quizResultModel.students[0].image.isNotEmpty)
                  ? Image.network(
                      quizResultModel.students[0].image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Images.noImage,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      Images.noImage,
                      fit: BoxFit.contain,
                    ),
              height: 200.h,
              border: Border(
                bottom: BorderSide(color: appColors.orang, width: 4),
                top: BorderSide(color: appColors.orang, width: 4),
              ),
            ),
            ListViewContainer(
              name: quizResultModel.students[2].name,
              score: quizResultModel.students[2].gainedPoints.toString(),
              rank: quizResultModel.students[2].rank.toString(),
              rankColor: appColors.ok,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25.r)),
              image: (quizResultModel.students[2].image != null &&
                      quizResultModel.students[2].image.isNotEmpty)
                  ? Image.network(
                      quizResultModel.students[2].image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Images.noImage,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      Images.noImage,
                      fit: BoxFit.contain,
                    ),
              height: 150.h,
              border: Border(
                bottom: BorderSide(color: appColors.ok, width: 4),
                right: BorderSide(color: appColors.ok, width: 4),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 450.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    appColors.primary,
                    appColors.pageBackground,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
            ),
            GridviewCaerLeader(
              students: quizResultModel.students,
              questionCount: quizResultModel.questionCount,
            ),
          ],
        ),
      ],
    );
  }
}
