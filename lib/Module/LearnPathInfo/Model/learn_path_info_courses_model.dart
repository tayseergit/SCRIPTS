class LearnPathInfoCourseResponse {
  final bool successful;
  final String message;
  final List<LearnPathInfoCourse> data;

  LearnPathInfoCourseResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory LearnPathInfoCourseResponse.fromJson(Map<String, dynamic> json) {
    return LearnPathInfoCourseResponse(
      successful: json['successful'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((courseJson) => LearnPathInfoCourse.fromJson(courseJson))
          .toList(),
    );
  }
}

class LearnPathInfoCourse {
  final int id;
  final String titleOfCourse;
  final String descriptionOfCourse;
  final double rate;
  final String imageOfCourse;
  final String courseDuration;
  final int numberOfVideo;
  final int videoProgress;
  final int numberOfTest;
  final bool finalTestPassed;
  final String level;
  final int price;
  final int teacherId;
  final String teacherName;
  final String teacherImage;
  final String? status;
  final dynamic studentPaid;
  final List<LearningPath> learningPaths;

  LearnPathInfoCourse({
    required this.id,
    required this.titleOfCourse,
    required this.descriptionOfCourse,
    required this.rate,
    required this.imageOfCourse,
    required this.courseDuration,
    required this.numberOfVideo,
    required this.videoProgress,
    required this.numberOfTest,
    required this.finalTestPassed,
    required this.level,
    required this.price,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImage,
    this.status,
    this.studentPaid,
    required this.learningPaths,
  });

  factory LearnPathInfoCourse.fromJson(Map<String, dynamic> json) {
    return LearnPathInfoCourse(
      id: json['id'],
      titleOfCourse: json['title_of_course'],
      descriptionOfCourse: json['description_of_course'],
      rate: (json['rate'] as num).toDouble(),
      imageOfCourse: json['image_of_course'],
      courseDuration: json['course_duration'],
      numberOfVideo: json['number_of_video'],
      videoProgress: json['video_progress'],
      numberOfTest: json['number_of_test'],
      finalTestPassed: json['final_test_passed'],
      level: json['level'],
      price: json['price'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      teacherImage: json['teacher_image'],
      status: json['status'],
      studentPaid: json['student_paid'],
      learningPaths: (json['learning_paths'] as List<dynamic>)
          .map((path) => LearningPath.fromJson(path))
          .toList(),
    );
  }
}

class LearningPath {
  final int id;
  final String name;
  final String image;

  LearningPath({
    required this.id,
    required this.name,
    required this.image,
  });

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
