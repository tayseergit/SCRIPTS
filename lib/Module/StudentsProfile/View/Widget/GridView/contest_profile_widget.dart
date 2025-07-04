import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/Model/contest_model.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class ContestHistoryCard extends StatefulWidget {
  ContestHistoryCard({super.key, required this.cubit});
  final StudentProfileCubit cubit;
  @override
  State<ContestHistoryCard> createState() => _ContestHistoryCardState();
}

class _ContestHistoryCardState extends State<ContestHistoryCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      widget.cubit.getMyContest();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return SizedBox(
      height: 350.h,
      child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
        builder: (context, state) {
          if (state is ContestLoading) {
            return Center(
              child: SizedBox(
                  height: 100.h, child: Loading(height: 50.h, width: 50.h)),
            );
          } else if (state is ContestError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: appColors.red),
              ),
            );
          } else if (state is ContestSuccess) {
            final contests = widget.cubit.contestResponse?.contests ?? [];
            if (contests.isEmpty) {
              return ContestGrid(
                contestsResponse: widget.cubit.contestResponse!,
              );
            }

            return ContestGrid(
              contestsResponse: widget.cubit.contestResponse!,
            );
          } else {
            return const SizedBox(); // Initial or unknown state
          }
        },
      ),
    );
  }
}

/// Table header
class _HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 12.sp, color: Colors.black54);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(flex: 4, child: Text('Contest', style: style)),
            Expanded(flex: 2, child: Text('Date', style: style)),
            Expanded(flex: 1, child: Text('Rank', style: style)),
            Expanded(flex: 1, child: Text('Points', style: style)),
          ],
        ),
      ),
    );
  }
}

/// Single table row
class DataRow extends StatelessWidget {
  const DataRow(this._contest, {super.key});
  final Contest _contest;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              // Contest title + status
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthText(
                      text: _contest.name,
                      size: 13.sp,
                      color: appColors.blackGreen,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                    ),
                    AuthText(
                        text: _contest.type,
                        size: 10.sp,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w600)
                  ],
                ),
              ),
              // Date
              Expanded(
                flex: 2,
                child: AuthText(
                  text: '${_contest.date}',
                  size: 10.sp,
                  color: appColors.secondText,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                ),
              ),
              // Rank badge
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _Badge(
                    '#${_contest.rank}',
                    color: _contest.rank == 1
                        ? appColors.orang
                        : (_contest.rank == 2
                            ? appColors.purple
                            : appColors.lightGray),
                    textColor: _contest.rank == 1 || _contest.rank == 2
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
              // Points
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: AuthText(
                        text: "${_contest.points}",
                        size: 13.sp,
                        color: appColors.ok,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
        Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label,
      {this.color = const Color(0xFFE0E0E0),
      this.textColor = Colors.black87,
      super.key});

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AuthText(
            text: label,
            size: 10.sp,
            color: textColor,
            fontWeight: FontWeight.w600));
  }
}

class ContestGrid extends StatelessWidget {
  ContestGrid({Key? key, required this.contestsResponse}) : super(key: key);
  ContestResponse contestsResponse;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title & subtitle
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.emoji_events_outlined, color: appColors.primary),
              SizedBox(width: 6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthText(
                    text: 'Contest History',
                    size: 18.sp,
                    color: appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(text: 'Total Points: '),
                      TextSpan(
                        text: '${contestsResponse.totalPoints}',
                        style: TextStyle(
                          color: appColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Participated badge
          _Badge('${contestsResponse.contestsCount} Contests Participated',
              color: Colors.blue.shade100, textColor: Colors.blue.shade900),
          SizedBox(height: 18.h),

          /// Header row
          _HeaderRow(),

          /// Divider line
          Divider(thickness: 1, height: 0, color: Colors.grey.shade300),

          /// Data rows
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contestsResponse.contests.length,
            itemBuilder: (_, i) => DataRow(contestsResponse.contests[i]),
          )
        ],
      ),
    );
  }
}
