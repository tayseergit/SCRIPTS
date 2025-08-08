class CourseContentResponse {
  final bool successful;
  final String message;
  final CourseData data;

  CourseContentResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory CourseContentResponse.fromJson(Map<String, dynamic> json) {
    return CourseContentResponse(
      successful: json['successful'],
      message: json['message'],
      data: CourseData.fromJson(json['data']),
    );
  }
}

class CourseData {
  final int id;
  final String title;
  final String description;
  final bool isEnrolled;
  final int totalVideos;
  final int watchedVideos;
  final String courseProgress;
  final List<ContentItem> allContents; // القائمة الموحدة لجميع المحتويات

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
    List<dynamic> contentList = json['content'] ?? [];

    // تحويل كل عنصر إلى النوع المناسب من ContentItem (VideoItem أو TestItem)
    List<ContentItem> contents = contentList.map<ContentItem>((item) {
      if (item['type'] == 'video') {
        return VideoItem.fromJson(item);
      } else if (item['type'] == 'test') {
        return TestItem.fromJson(item);
      } else {
        // يمكن إضافة أنواع أخرى هنا إذا وجدت
        return ContentItem.fromJson(item);
      }
    }).toList();

    return CourseData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isEnrolled: json['is_enrolled'],
      totalVideos: json['total_videos'],
      watchedVideos: json['watched_videos'],
      courseProgress: json['course_progress'],
      allContents: contents,
    );
  }
}

/// الكلاس الأساسي لكل المحتويات
class ContentItem {
  final int id;
  final String title;
  final String type;
  final int order;

  ContentItem({
    required this.id,
    required this.title,
    required this.type,
    required this.order,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      order: json['order'],
    );
  }
}

/// موديل خاص للفيديوهات يرث من ContentItem
class VideoItem extends ContentItem {
  final String progress;
  final bool isFree;
  final bool watched;

  VideoItem({
    required int id,
    required String title,
    required String type,
    required int order,
    required this.progress,
    required this.isFree,
    required this.watched,
  }) : super(id: id, title: title, type: type, order: order);

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      order: json['order'],
      progress: json['progress'] ?? "0 %",
      isFree: json['is_free'] ?? false,
      watched: json['watched'] ?? false,
    );
  }
}

/// موديل خاص للاختبارات يرث من ContentItem
class TestItem extends ContentItem {
  final bool isFinal;
  final bool completed;

  TestItem({
    required int id,
    required String title,
    required String type,
    required int order,
    required this.isFinal,
    required this.completed,
  }) : super(id: id, title: title, type: type, order: order);

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      order: json['order'],
      isFinal: json['is_final'] ?? false,
      completed: json['completed'] ?? false,
    );
  }
}
    