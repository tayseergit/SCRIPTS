// learning_paths_response.dart
// ───────────────────────────────────────────────────────────
// نموذج كامل لهيكلة الـ JSON المرفق.

/*  المستوى الأعلى  */
class LearningPathsResponse {
  final bool successful;
  final String message;
  final LearningPathsData data;

  LearningPathsResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory LearningPathsResponse.fromJson(Map<String, dynamic> json) =>
      LearningPathsResponse(
        successful: json['successful'] as bool,
        message: json['message'] as String,
        data: LearningPathsData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'successful': successful,
        'message': message,
        'data': data.toJson(),
      };
}

/*  محتوى data  */
class LearningPathsData {
  final List<LearningPath> learningPaths;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  LearningPathsData({
    required this.learningPaths,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory LearningPathsData.fromJson(Map<String, dynamic> json) =>
      LearningPathsData(
        learningPaths: (json['learningPaths'] as List<dynamic>)
            .map((e) => LearningPath.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int,
        currentPage: json['current_page'] as int,
        hasMorePages: json['hasMorePages'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'learningPaths': learningPaths.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'current_page': currentPage,
        'hasMorePages': hasMorePages,
      };
}

/*  عنصر الـ learningPaths  */
class LearningPath {
  final int id;
  final String title;
  final String description;
  final String image;
  final double rate;
  final int coursesCount;
  final String totalCoursesPrice;
  final int teacherId;
  final String teacherName;
  final String teacherImage;
  final String? status; // يمكن أن يكون null

  LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rate,
    required this.coursesCount,
    required this.totalCoursesPrice,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImage,
    required this.status,
  });

  factory LearningPath.fromJson(Map<String, dynamic> json) {
 String totalPrice = json['total_courses_price'];
    
     
        totalPrice = totalPrice.split('.').first.trim();
      
    
   return LearningPath(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      rate: (json['rate'] as num).toDouble(),
      coursesCount: json['courses_count'] as int,
      totalCoursesPrice: totalPrice,
      teacherId: json['teacher_id'] as int,
      teacherName: json['teacher_name'] as String,
      teacherImage: json['teacher_image'] as String,
      status: json['status'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'rate': rate,
        'courses_count': coursesCount,
        'total_courses_price': totalCoursesPrice,
        'teacher_id': teacherId,
        'teacher_name': teacherName,
        'teacher_image': teacherImage,
        'status': status,
      };
}
