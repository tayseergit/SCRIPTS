import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoPlayerController? controller;

  VideoCubit() : super(VideoInitial());

  Future<void> loadVideo(String assetPath) async {
    emit(VideoLoading());

    try {
      controller = VideoPlayerController.asset(assetPath);
      await controller!.initialize();
      emit(VideoLoaded(controller!));
    } catch (e) {
      emit(VideoError("Failed to load video: $e"));
    }
  }

  void dispose() {
    controller?.dispose();
  }
}
