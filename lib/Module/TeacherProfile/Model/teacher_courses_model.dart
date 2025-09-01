class CourseModel {
  final bool status;
  final List<TeacherCourse> courses;
  final Meta meta;

  CourseModel({
    required this.status,
    required this.courses,
    required this.meta,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      status: json['status'],
      courses: List<TeacherCourse>.from(json['courses'].map((x) => TeacherCourse.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class TeacherCourse {
  final int id;
  final String titleOfCourse;
  final String descriptionOfCourse;
  final String rate;
  final String? imageOfCourse;
  final int numberOfVideo;
  final int numberOfTest;
  final String price;
  final int teacherId;
  final String teacherName;
  final String? teacherImage;
  final String level;
  final String course_duration;

  TeacherCourse({
    required this.id,
    required this.titleOfCourse,
    required this.descriptionOfCourse,
    required this.rate,
    required this.imageOfCourse,
    required this.numberOfVideo,
    required this.numberOfTest,
    required this.price,
    required this.teacherId,
    required this.teacherName,
    this.teacherImage,
    required this.level,
    required this.course_duration
  });

  factory TeacherCourse.fromJson(Map<String, dynamic> json) {
    return TeacherCourse(
      id: json['id'],
      titleOfCourse: json['title_of_course'],
      descriptionOfCourse: json['description_of_course'],
      rate: json['rate'],
      imageOfCourse: json['image_of_course'],
      numberOfVideo: json['number_of_video'],
      numberOfTest: json['number_of_test'],
      price: json['price'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      teacherImage: json['teacher_image'],
      level: json['level'],
      course_duration: json['course_duration'],
    );
  }
}

class Meta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
