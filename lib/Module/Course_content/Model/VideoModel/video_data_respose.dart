class VideoDataResponse {
  bool successful;
  String message;
  VideoData data;

  VideoDataResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory VideoDataResponse.fromJson(Map<String, dynamic> json) => VideoDataResponse(
    successful: json["successful"],
    message: json["message"],
    data: VideoData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successful": successful,
    "message": message,
    "data": data.toJson(),
  };
}

class VideoData {
  int id;
  String title;
  String description;
  int order;
  String url;
  int duration;
  String createdAt;
  dynamic isCompleted; // nullable
  dynamic progress;    // nullable
  dynamic lastWatchedAt; // nullable

  VideoData({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.url,
    required this.duration,
    required this.createdAt,
    this.isCompleted,
    this.progress,
    this.lastWatchedAt,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    order: json["order"],
    url: json["url"],
    duration: json["duration"],
    createdAt: json["created_at"],
    isCompleted: json["is_completed"],
    progress: json["progress"],
    lastWatchedAt: json["last_watched_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "order": order,
    "url": url,
    "duration": duration,
    "created_at": createdAt,
    "is_completed": isCompleted,
    "progress": progress,
    "last_watched_at": lastWatchedAt,
  };
}
