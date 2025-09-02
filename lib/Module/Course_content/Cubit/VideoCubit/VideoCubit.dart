// lib/Module/Course_content/Cubit/VideoCubit/video_cubit.dart

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/Course_content/Model/VideoModel/video_data_respose.dart';
import 'package:lms/Module/Course_content/cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // لإضافة Timer

// باقي imports كما هي

class VideoCubit extends Cubit<VideoState> {
  YoutubePlayerController? youtubeController;
  VideoDataResponse? videoDataResponse;
  Timer? _progressTimer; // مؤقت للتحكم في إرسال API التقدم
  int courseId;
  int? videoId;
  VideoCubit({required this.courseId}) : super(const VideoInitialYouTube());

  Future<void> loadVideoFromApi(
    BuildContext context, {
    required int videoId,
  }) async {
    print("video id $videoId");
    emit(VideoLoadingYouTube(selectedVideo: videoId));
    this.videoId = videoId;

    try {
      final response = await DioHelper.getData(
        url: "courses/$courseId/video/$videoId",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );
      print(response.data["data"]);
      if (response.statusCode == 200 && response.data["successful"] == true) {
        final data = response.data["data"];
        videoDataResponse = VideoDataResponse.fromJson(response.data);
        String? videoUrl = data["url"];
        String? videoIdFromUrl = YoutubePlayer.convertUrlToId(videoUrl ?? "");

        if (videoIdFromUrl == null || videoIdFromUrl.isEmpty) {
          emit(VideoErrorYoutube(
            selectedVideo: videoId,
            message: S.of(context).invalid_video_url,
          ));
          return;
        }

        _progressTimer?.cancel();
        if (youtubeController != null) {
          youtubeController!.removeListener(videoProgressListener);
          youtubeController!.dispose();
        }
        print("vvvvvvvvvvvvvvvv");

        youtubeController = YoutubePlayerController(
          initialVideoId: videoIdFromUrl,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
        emit(VideoSuccessYouTube(
          selectedVideo: videoId,
          title: data["title"] ?? "",
          description: data["description"] ?? "",
        ));
        // إضافة مستمع جديد
        youtubeController!.addListener(() {
          // seek to saved progress
          final savedProgressPercent = videoDataResponse?.data.progress ?? 0.0;
          if (savedProgressPercent > 0 &&
              savedProgressPercent < 100 &&
              youtubeController!.value.position.inSeconds == 0 &&
              youtubeController!.value.isReady) {
            final duration = youtubeController!.metadata.duration;
            if (duration.inSeconds > 0) {
              final startSeconds =
                  (savedProgressPercent / 100) * duration.inSeconds;
              youtubeController!
                  .seekTo(Duration(seconds: startSeconds.toInt()));
            }
          }

          // متابعة التقدم وارسال API
          videoProgressListener();
        });

        emit(VideoSuccessYouTube(
          selectedVideo: videoId,
          title: data["title"] ?? "",
          description: data["description"] ?? "",
        ));
      } else if (response.statusCode == 401) {
        emit(UnAuth());
        return;
      } else {
        emit(VideoErrorYoutube(
            selectedVideo: videoId,
            // message: S.of(context).fetch_video_failed,
            message: response.data['message']));
      }
    } catch (e) {
      emit(VideoErrorYoutube(
          selectedVideo: videoId,
          // message: S.of(context).connection_error,
          message: e.toString()));
    }
  }

  void videoProgressListener() {
    if (youtubeController!.value.isFullScreen) {
      // Full Screen: اخفاء النظام
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      // Small Mode: إظهار النظام
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
    if (youtubeController == null) return;

    final position = youtubeController!.value.position;
    final duration = youtubeController!.metadata.duration;

    if (duration != null && position != null && duration.inMilliseconds > 0) {
      final progressPercent = position.inMilliseconds / duration.inMilliseconds;

      // إرسال التقدم كل 20 ثانية
      if (videoDataResponse!.data.progress != 100) {
        if (_progressTimer == null || !_progressTimer!.isActive) {
          sendProgressToApi(progressPercent);
          _progressTimer = Timer(Duration(seconds: 10), () {
            _progressTimer = null; // reset timer so next call works
          });
        }
      }
    }
  }

  Future<void> sendProgressToApi(double progress) async {
    try {
      // emit(VideoProgressUpdated());

      final response = await DioHelper.postData(
        url: "courses/$courseId/video/$videoId/updateProgress",
        postData: {"progress": progress * 100},
        headers: {
          "Authorization": "Bearer ${CacheHelper.getToken()}",
          "Accept": "application/json",
        },
      ).then((response) {
        if (response.statusCode == 200) {
          videoDataResponse!.data.isCompleted = 1;
          emit(Update());
        }
      });
      print("Progress sent: ${progress * 100}");
    } catch (e) {
      print("Failed to send progress: $e");
    }
  }

  void loadNextVideo(BuildContext context, List<dynamic> allContents) {
    if (videoId == null) return;

    // find current index by id
    final currentIndex = allContents.indexWhere(
      (content) => content.id == videoId,
    );

    if (currentIndex != -1) {
      // find the next item in the list with type "video"
      final nextIndex = allContents.indexWhere(
        (content) => content.type == "video",
        currentIndex + 1, // start searching after current
      );

      if (nextIndex != -1) {
        final nextVideo = allContents[nextIndex];
        print("Next video id: ${nextVideo.id}");

        loadVideoFromApi(context, videoId: nextVideo.id);
      } else {
        print("No more videos found in the list!");
        // You could emit a "finished" state here
        emit(Update());
      }
    }
  }

  @override
  Future<void> close() async {
    // Cancel timers
    _progressTimer?.cancel();

    // Dispose youtube controller safely
    if (youtubeController != null) {
      // youtubeController!.pause();
      // youtubeController!.dispose();
      // youtubeController = null;
    }

    // Always call super.close at the end
    // return super.close();
  }
}
