import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/Participants/Cubit/participants_state.dart';
import 'package:lms/Module/Participants/View/Widget/Participants_gridview.dart';
import 'package:lms/Module/Participants/View/Widget/order_options_sheet.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ParticipantsCubit()..fetchAllParticipants()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<ParticipantsCubit, ParticipantsState>(
          listener: (context, state) {
            if (state is ParticpantsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masseg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ParticpantsLoding &&
                context.read<ParticipantsCubit>().lastUsers == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ParticpantsError) {
              return Center(
                child: Text(
                  state.masseg,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              final teacherList =
                  context.read<ParticipantsCubit>().lastUsers?.users ?? [];

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  SizedBox(height: 140.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 150),
                      child: Customtextfieldsearsh(
                        onChanged: (value) {
                          final query = value.trim();
                          if (query.isNotEmpty) {
                            context
                                .read<ParticipantsCubit>()
                                .searchParticipants(query);
                          } else {
                            context
                                .read<ParticipantsCubit>()
                                .fetchAllParticipants();
                          }
                        },
                        borderRadius: 6,
                        controller: search,
                        borderColor: appColors.primary,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: appColors.iconSearsh,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            final cubit = context.read<ParticipantsCubit>();
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => OrderOptionsSheet(cubit: cubit),
                            );
                          },
                          child: Image.asset(
                            Images.filter,
                            width: 17.w,
                            height: 17.h,
                            color: appColors.iconSearsh,
                          ),
                        ),
                        hintText: 'which teacher?',
                        hintFontSize: 13.sp,
                        hintFontWeight: FontWeight.w600,
                        fillColor: appColors.pageBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  ParticipantsGridview(teacher: teacherList)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
