// lib/screens/video_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Vedio/CommentCubit.dart';
import 'package:lms/Module/Vedio/GridViewCourses.dart';
import 'package:lms/Module/Vedio/GridViewVedio.dart';
import 'package:lms/Module/Vedio/VideoCubit.dart';
import 'package:lms/Module/Vedio/VideoState.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VideoCubit()..initializeVideo()),
        BlocProvider(create: (_) => CommentCubit()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: ListView(
          children: [
            Container(
              width: double.infinity.w,
              height: 300.h,
              child: BlocBuilder<VideoCubit, VideoState>(
                builder: (context, state) {
                  if (state is VideoLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is VideoLoaded) {
                    return Chewie(controller: state.chewieController);
                  } else if (state is VideoError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text("جارٍ تحميل الفيديو..."));
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Row(
                children: [
                  AuthText(
                    text: '01',
                    size: 24,
                    color: appColors.secondText,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  AuthText(
                    text: 'Welcome to the Course',
                    size: 24,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: AuthText(
                text:
                    'Ultrices vitae auctor eu augue. Tincidunt id aliquet risus.',
                size: 15,
                color: appColors.secondText,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: BlocBuilder<CommentCubit, bool>(
                builder: (context, isExpanded) {
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColors.lightGray,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AuthText(
                              text: 'Comments',
                              size: 16,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(Images.courses),
                              ),
                              SizedBox(width: 10.w),
                              AuthText(
                                text: 'savzvxvzvzvxxvzvzvzxvxvz',
                                size: 10,
                                color: appColors.secondText,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(width: 100.w),
                              IconButton(
                                onPressed: () {
                                  context.read<CommentCubit>().toggleExpand();
                                },
                                icon: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            SizedBox(height: 10.h),
                            Gridviewvedio(),
                            SizedBox(height: 100.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              child: OnBoardingContainer(
                                width: double.infinity,
                                height: 50,
                                color: appColors.border,
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage: AssetImage(
                                        Images.courses,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: appColors.primary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: TextField(
                                            controller: controller,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: appColors.mainText,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Add Review',
                                              hintStyle: TextStyle(
                                                  color: appColors.secondText),
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.send,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: GridviewVediocourses(),
            ),
          ],
        ),
      ),
    );
  }
}
