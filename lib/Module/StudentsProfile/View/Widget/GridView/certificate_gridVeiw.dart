import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Cards/cetificate_card.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class CirtificateGridview extends StatefulWidget {
  final StudentProfileCubit cubit;

  const CirtificateGridview({super.key, required this.cubit});

  @override
  State<CirtificateGridview> createState() => _CirtificateGridviewState();
}

class _CirtificateGridviewState extends State<CirtificateGridview> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      widget.cubit.getCirtificate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return SizedBox(
      height: 350.h,
      child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
        builder: (context, state) {
          if (state is CertificatesLoading) {
            return Center(
              child: SizedBox(
                  height: 100.h, child: Loading(height: 50.h, width: 50.h)),
            );
          } else if (state is CertificatesError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: appColors.red),
              ),
            );
          } else if (state is CertificatesSuccess) {
            final certs = widget.cubit.certificateResponse?.certificates ?? [];
            if (certs.isEmpty) {
              return Center(
                child: NoItem(),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.only(top: 17.h, left: 10.w, right: 10.w),
              itemCount: certs.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220.w,
                childAspectRatio: 1,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 5.w,
              ),
              itemBuilder: (ctx, index) {
                // Use real data in your actual card
                return CetifiateCard(certificate: certs[index]);
              },
            );
          } else {
            return const SizedBox(); // Initial or unknown state
          }
        },
      ),
    );
  }
}
