abstract class VideoState {
  final int? selectedVideo;
  const VideoState({this.selectedVideo});
}

class VideoInitialYouTube extends VideoState {
  const VideoInitialYouTube({int? selectedVideo})
      : super(selectedVideo: selectedVideo);
}

class VideoLoadingYouTube extends VideoState {
  const VideoLoadingYouTube({required int selectedVideo})
      : super(selectedVideo: selectedVideo);
}

class VideoSuccessYouTube extends VideoState {
  final String title;
  final String description;
  const VideoSuccessYouTube({
    int? selectedVideo,
    required this.title,
    required this.description,
  }) : super(selectedVideo: selectedVideo);
}

class VideoErrorYoutube extends VideoState {
  final String message;
  const VideoErrorYoutube({int? selectedVideo, required this.message})
      : super(selectedVideo: selectedVideo);
}

class VideoProgressUpdated extends VideoState {
 
}