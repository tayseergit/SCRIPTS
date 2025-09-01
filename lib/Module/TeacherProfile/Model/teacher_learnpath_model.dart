class TeacherLearnPath {
  final bool status;
  final List<TeacherLearnpathModel> learningPaths;
  final Meta meta;

  TeacherLearnPath({
    required this.status,
    required this.learningPaths,
    required this.meta,
  });

  factory TeacherLearnPath.fromJson(Map<String, dynamic> json) {
    return TeacherLearnPath(
      status: json['status'],
      learningPaths: List<TeacherLearnpathModel>.from(
        json['learningPaths'].map((x) => TeacherLearnpathModel.fromJson(x)),
      ),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class TeacherLearnpathModel {
  final int id;
  final String title;
  final String description;
  final String? image;
  final double rate;
  final int coursesCount;
  final int teacherId;
  final String totalCoursesPrice;
  final String teacherName;
  final int verified;
  final String price;

  TeacherLearnpathModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rate,
    required this.coursesCount,
    required this.teacherId,
    required this.totalCoursesPrice,
    required this.teacherName,
    required this.verified,
    required this.price,
  });

  factory TeacherLearnpathModel.fromJson(Map<String, dynamic> json) {
    return TeacherLearnpathModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image']?? '',
      rate: (json['rate'] as num).toDouble(),
      coursesCount: json['courses_count'],
      teacherId: json['teacher_id'],
      totalCoursesPrice: json['total_courses_price'],
      teacherName: json['teacher_name'],
      verified: json['verified'],
      price: json['price'],
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
