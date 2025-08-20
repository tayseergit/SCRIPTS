class CourseContentResponse {
  bool successful;
  String message;
  CourseData? data;

  CourseContentResponse({
    required this.successful,
    required this.message,
    this.data,
  });

  factory CourseContentResponse.fromJson(Map<String, dynamic> json) {
    return CourseContentResponse(
      successful: json['successful'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? CourseData.fromJson(json['data']) : null,
    );
  }
}

class CourseData {  
  int id;
  String title;
  String description;
  bool isEnrolled;
  int totalVideos;
  int watchedVideos;
  String courseProgress;
  List<ContentItem> allContents;

  CourseData({
    required this.id,
    required this.title,
    required this.description,
    required this.isEnrolled,
    required this.totalVideos,
    required this.watchedVideos,
    required this.courseProgress,
    required this.allContents,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isEnrolled: json['is_enrolled'] ?? false,
      totalVideos: json['total_videos'] ?? 0,
      watchedVideos: json['watched_videos'] ?? 0,
      courseProgress: json['course_progress'] ?? '',
      allContents: (json['content'] as List<dynamic>)
          .map((item) => ContentItem.fromJson(item))
          .toList(),
    );
  }
}

class ContentItem {
  int id;
  String title;
  String type;
  int order;
  String? progress; // for videos
  bool? isFree; // for videos
  bool? watched; // for videos
  bool? isFinal; // for tests
  bool ? completed; // for tests

  ContentItem({
    required this.id,
    required this.title,
    required this.type,
    required this.order,
    this.progress,
    this.isFree,
    this.watched,
    this.isFinal,
     this.completed,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      order: json['order'] ?? 0,
      progress: json['progress'],
      isFree: json['is_free'],
      watched: json['watched'],
      isFinal: json['is_final'],
      completed: json['completed'],
    );
  }
}
