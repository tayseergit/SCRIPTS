class CourseDescriptionResponse {
  final bool successful;
  final String message;
  final CourseData data;

  CourseDescriptionResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory CourseDescriptionResponse.fromJson(Map<String, dynamic> json) {
    return CourseDescriptionResponse(
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
  final String rate;
  final String ?image;
  final String price;
  final String level;
    String? status;
    String? studentPaid; // changed to String? to match API
  final int numberOfVideos;
  final String duration; // changed to String
  final int numberOfParticipants;
  final int teacherId;
  final String teacherName;
  final String? teacherImage;
    String ?teacherBio;
  final int numberOfTeacherCourses;
  final List<LearningPath> learningPaths;

  CourseData({
    required this.id,
    required this.title,
    required this.description,
    required this.rate,
    required this.image,
    required this.price,
    required this.level,
    this.status,
    this.studentPaid,
    required this.numberOfVideos,
    required this.duration,
    required this.numberOfParticipants,
    required this.teacherId,
    required this.teacherName,
    this.teacherImage,
      this.teacherBio,
    required this.numberOfTeacherCourses,
    required this.learningPaths,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rate: json['rate'],
      image: json['image'],
      price: json['price'],
      level: json['level'],
      status: json['status'],
      studentPaid: json['student_paid'],
      numberOfVideos: json['number_of_videos'],
      duration: json['duration'], // now string
      numberOfParticipants: json['number_of_participants'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      teacherImage: json['teacher_image'],
      teacherBio: json['teacher_bio'],
      numberOfTeacherCourses: json['number_of_teacher_courses'],
      learningPaths: (json['learning_paths'] as List)
          .map((e) => LearningPath.fromJson(e))
          .toList(),
    );
  }
}

class LearningPath {
  final int id;
  final String title;
  final String image;

  LearningPath({
    required this.id,
    required this.title,
    required this.image,
  });

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
