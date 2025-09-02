import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;
  final int videoId;

  const VideoPlayerWidget({required this.controller, required this.videoId, super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      key: ValueKey(videoId),
      controller: controller,
      onEnded: (metaData) {
        final courseContentCubit = context.read<CourseContentCubit>();
        final allContents = courseContentCubit
            .courseContentResponse!.data!.allContents;
        context.read<VideoCubit>().loadNextVideo(context, allContents);
      },
    );
  }
}
