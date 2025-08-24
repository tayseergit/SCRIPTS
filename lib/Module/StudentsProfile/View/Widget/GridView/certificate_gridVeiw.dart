import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Cards/cetificate_card.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class CirtificateGridview extends StatefulWidget {
  final StudentProfileCubit cubit;

  const CirtificateGridview({super.key, required this.cubit});

  @override
  State<CirtificateGridview> createState() => _CirtificateGridviewState();
}

class _CirtificateGridviewState extends State<CirtificateGridview>
    with SingleTickerProviderStateMixin {
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
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate max cross-axis extent (responsive card size)
    double maxCrossAxisExtent =
        (screenWidth / 2) - 20; // 2 items per row approx.

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
              return Center(child: NoItem());
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h),
              itemCount: certs.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent, // responsive size
                childAspectRatio: 0.9,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (ctx, index) {
                final certificate = certs[index];

                // Wrap card with animated slide-in effect
                return TweenAnimationBuilder<Offset>(
                  tween: Tween<Offset>(
                      begin: const Offset(1, 0), end: const Offset(0, 0)),
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  curve: Curves.easeOut,
                  builder: (context, offset, child) {
                    return Transform.translate(
                      offset: offset * 50, // Move 50px initially
                      child: Opacity(
                        opacity: 1 - offset.dx.abs(),
                        child: CertificateCard(certificate: certificate),
                      ),
                    );
                  },
                );
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
