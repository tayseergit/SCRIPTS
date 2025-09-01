class CoursesResponse {
  final bool successful;
  final String message;
  final CoursesData data;

  CoursesResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory CoursesResponse.fromJson(Map<String, dynamic> json) {
    return CoursesResponse(
      successful: json['successful'],
      message: json['message'],
      data: CoursesData.fromJson(json['data']),
    );
  }
}

class CoursesData {
  final List<Course> courses;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  CoursesData({
    required this.courses,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory CoursesData.fromJson(Map<String, dynamic> json) {
    return CoursesData(
      courses: (json['courses'] as List)
          .map((course) => Course.fromJson(course))
          .toList(),
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}

class Course {
  final int id;
  final String titleOfCourse;
  final String descriptionOfCourse;
  final dynamic rate;
  final String? imageOfCourse;
  final String courseDuration;
  final int numberOfVideo;
  final String videoProgress;
  final int numberOfTest;
  final bool finalTestPassed;
  final String level;
  final int price;
  final int teacherId;
  final String teacherName;
  final String? teacherImage;
  final String? status;
  final dynamic studentPaid;
  final List<LearningPath> learningPaths;

  Course({
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
    required this.status,
    required this.studentPaid,
    required this.learningPaths,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    String durationString = json['course_duration'];
    String hourNumber = '0'; // default value

    if (durationString.isNotEmpty) {
      try {
        // Split the string by ":" and take the first part, then remove any spaces
        hourNumber = durationString.split(':').first.trim();
      } catch (e) {
        print('Error parsing course duration: $e');
      }
    }
    return Course(
      id: json['id'],
      titleOfCourse: json['title_of_course'],
      descriptionOfCourse: json['description_of_course'],
      rate: json['rate'],
      imageOfCourse: json['image_of_course'],
      courseDuration: hourNumber,
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
      learningPaths: (json['learning_paths'] as List)
          .map((lp) => LearningPath.fromJson(lp))
          .toList(),
    );
  }
}

class LearningPath {
  final int id;
  final String name;
  final String?? image; 

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

