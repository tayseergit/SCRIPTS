class LearningPathInfoModel {
  final bool successful;
  final String message;
  final LearningPathInfoData data;

  LearningPathInfoModel({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory LearningPathInfoModel.fromJson(Map<String, dynamic> json) {
    return LearningPathInfoModel(
      successful: json['successful'] ?? false,
      message: json['message'] ?? '',
      data: LearningPathInfoData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'successful': successful,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class LearningPathInfoData {
  final int id;
  final String title;
  final String description;
  final String image;
  final double rate;
  final int coursesCount;
  final String totalCoursesPrice;
  final String totalDuration;
  final int teacherId;
  final String teacherName;
  final String teacherImage;
  final String teacherBio;
  final int teacherCoursesCount;
  final String? status;

  LearningPathInfoData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rate,
    required this.coursesCount,
    required this.totalCoursesPrice,
    required this.totalDuration,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImage,
    required this.teacherBio,
    required this.teacherCoursesCount,
    this.status,
  });

  factory LearningPathInfoData.fromJson(Map<String, dynamic> json) {
    return LearningPathInfoData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      rate: (json['rate'] != null ? (json['rate'] as num).toDouble() : 0.0),
      coursesCount: json['courses_count'] ?? 0,
      totalCoursesPrice: json['total_courses_price'] ?? '0',
      totalDuration: json['total_duration'] ?? '0h 0min',
      teacherId: json['teacher_id'] ?? 0,
      teacherName: json['teacher_name'] ?? '',
      teacherImage: json['teacher_image'] ?? '',
      teacherBio: json['teacher_bio'] ?? '',
      teacherCoursesCount: json['teacher_courses_count'] ?? 0,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'rate': rate,
      'courses_count': coursesCount,
      'total_courses_price': totalCoursesPrice,
      'total_duration': totalDuration,
      'teacher_id': teacherId,
      'teacher_name': teacherName,
      'teacher_image': teacherImage,
      'teacher_bio': teacherBio,
      'teacher_courses_count': teacherCoursesCount,
      'status': status,
    };
  }
}
