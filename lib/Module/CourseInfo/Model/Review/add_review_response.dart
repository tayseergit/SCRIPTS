class AddReviewResponse {
  final bool successful;
  final String message;
  final ReviewData data;

  AddReviewResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) {
    return AddReviewResponse(
      successful: json['successful'],
      message: json['message'],
      data: ReviewData.fromJson(json['data']),
    );
  }
}

class ReviewData {
  final int id;
  final String comment;
  final int rate;
  final String createdAt;
  final bool yourReview;
  final Student student;

  ReviewData({
    required this.id,
    required this.comment,
    required this.rate,
    required this.createdAt,
    required this.yourReview,
    required this.student,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'],
      comment: json['comment'],
      rate: json['rate'],
      createdAt: json['created_at'],
      yourReview: json['your_review'],
      student: Student.fromJson(json['student']),
    );
  }
}

class Student {
  final int id;
  final String name;
  final String? image;

  Student({
    required this.id,
    required this.name,
    this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
