// lib/cubits/video_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoCubit extends Cubit<VideoState> {
  late VideoPlayerController videoController;
  ChewieController? chewieController;

  VideoCubit() : super(VideoInitial());

  Future<void> initializeVideo() async {
    emit(VideoLoading());

    try {
      videoController = VideoPlayerController.asset('assets/video/VID.mp4');
      await videoController.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: false,
        looping: false,
      );

      emit(VideoLoaded(chewieController!));
    } catch (e) {
      emit(VideoError('فشل تحميل الفيديو: $e'));
    }
  }

  @override
  Future<void> close() {
    videoController.dispose();
    chewieController?.dispose();
    return super.close();
  }
}
