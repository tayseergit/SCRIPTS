import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/leader_board_cubit.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/leader_board_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/leader_listview.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/tap.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/tap_cubit.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class Leaderboardforpastcontestpage extends StatelessWidget {
  final int contestId;
  const Leaderboardforpastcontestpage({
    super.key,
    required this.contestId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TapLeadercubit(),
        ),
        BlocProvider(
          create: (_) => LeaderBoardCubit()..fetchLeaderBoards(contestId),
        ),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<LeaderBoardCubit, LeaderBoardState>(
          listener: (context, state) {
            if (state is LeaderBoardSuccess) {
              print('🟢 [D] تم استلام LeaderBoardSuccess');
            }
          },
          builder: (context, state) {
            if (state is LeaderBoardLoading) {
              return Center(
                child: SizedBox(
                  height: 80.h,
                  child: Loading(height: 50.h, width: 50.w),
                ),
              );
            } else if (state is LeaderBoardError) {
              return Center(child: NoConnection());
            } else if (state is LeaderBoardSuccess) {
              return SafeArea(
                child: ListView(
                  children: [
                    // ====== الهيدر ======
                    Stack(
                      children: [
                        ClipPath(
                          clipper: TopWaveMoreClipper(),
                          child: Container(
                            decoration:
                                BoxDecoration(gradient: appColors.linear),
                            width: double.infinity,
                            height: 150.h,
                          ),
                        ),
                        Positioned(
                          top: 20.h,
                          left: 16.w,
                          child: AuthText(
                            text: S.of(context).leader,
                            size: 30,
                            color: appColors.mainText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: 10,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Tap(), // أزرار التبويبات
                          ),
                        ),
                      ],
                    ),

                    BlocBuilder<TapLeadercubit, int>(
                      builder: (context, tabIndex) {
                        switch (tabIndex) {
                          case 0:
                            if (state.allResult != null) {
                              return LeaderListView(
                                quizResultModel: state.allResult!,
                              );
                            } else {
                              return Center(child: Text('لا يوجد بيانات للكل'));
                            }
                          case 1:
                            if (state.friendsResult != null) {
                              return LeaderListView(
                                quizResultModel: state.friendsResult!,
                              );
                            } else {
                              return Center(
                                  child: Text('لا يوجد بيانات للأصدقاء'));
                            }
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
