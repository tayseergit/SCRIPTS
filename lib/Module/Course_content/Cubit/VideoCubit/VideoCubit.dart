// lib/Module/Course_content/Cubit/VideoCubit/video_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoState.dart';
import 'package:lms/Module/Course_content/Model/video_data_respose.dart';
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
        youtubeController?.removeListener(
            _videoProgressListener); // إزالة المستمع القديم لو موجود
        youtubeController?.dispose(); // التخلص من الكنترولر القديم

        youtubeController = YoutubePlayerController(
          initialVideoId: videoIdFromUrl,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        )..addListener(_videoProgressListener);

// قراءة النسبة من الـ API
        final savedProgressPercent =
            videoDataResponse?.data.progress ?? 0.0; // مثال: 75

        if (savedProgressPercent > 0) {
          VoidCallback? seekListener;

          seekListener = () {
            if (youtubeController!.value.isReady) {
              final duration = youtubeController!.metadata.duration;

              if (duration.inSeconds > 0) {
                // تحويل النسبة إلى وقت بالثواني
                final startSeconds =
                    (savedProgressPercent / 100) * duration.inSeconds;

                youtubeController!
                    .seekTo(Duration(seconds: startSeconds.toInt()));
              }

              // إزالة المستمع بعد التقديم لمرة واحدة
              youtubeController!.removeListener(seekListener!);
              seekListener = null;
            }
          };

          youtubeController!.addListener(seekListener!);
        }

        emit(VideoSuccessYouTube(
          selectedVideo: videoId,
          title: data["title"] ?? "",
          description: data["description"] ?? "",
        ));
      } else {
        emit(VideoErrorYoutube(
          selectedVideo: videoId,
          message: S.of(context).fetch_video_failed,
        ));
      }
    } catch (e) {
      emit(VideoErrorYoutube(
        selectedVideo: videoId,
        message: S.of(context).connection_error,
      ));
    }
  }

  void _videoProgressListener() {
    if (youtubeController == null) return;

    final position = youtubeController!.value.position;
    final duration = youtubeController!.value.metaData.duration;

    if (duration != null && position != null && duration.inMilliseconds > 0) {
      final progressPercent = position.inMilliseconds / duration.inMilliseconds;

      // تحديث الواجهة مع التقدم الحالي فوراً (اختياري)

      // فقط إذا لم يكن المؤقت مفعل، يتم إرسال بيانات التقدم وتهيئة المؤقت
      if (_progressTimer == null || !_progressTimer!.isActive) {
        _sendProgressToApi(progressPercent, videoId!);
        _progressTimer = Timer(Duration(seconds: 20), () {});
      }
    }
  }

  Future<void> _sendProgressToApi(double progress, int videoId) async {
    try {
      // emit(VideoProgressUpdated());

      print("pppppppppppppppppp");
      await DioHelper.postData(
        url: "courses/$courseId/video/$videoId/updateProgress",
        postData: {"progress": progress * 100},
        headers: {
          "Authorization": "Bearer ${CacheHelper.getToken()}",
          "Accept": "application/json",
        },
      );
      print("Progress sent: ${progress * 100}");
    } catch (e) {
      print("Failed to send progress: $e");
    }
  }

  @override
  Future<void> close() {
    _progressTimer?.cancel();
    youtubeController?.removeListener(_videoProgressListener);
    youtubeController?.dispose();
    return super.close();
  }
}
