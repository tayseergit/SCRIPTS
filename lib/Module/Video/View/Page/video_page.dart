import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Video/Cubit/video_cubit.dart';
import 'package:video_player/video_player.dart';
 
class VideoPage extends StatelessWidget {
  final String assetPath; // Example: 'assets/videos/sample.mp4'

  const VideoPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoCubit()..loadVideo(assetPath),
      child: Scaffold(
        appBar: AppBar(title: const Text('Asset Video Player')),
        body: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoLoaded) {
              final controller = state.controller;
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    },
                    child: Icon(
                      controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                ],
              );
            } else if (state is VideoError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
