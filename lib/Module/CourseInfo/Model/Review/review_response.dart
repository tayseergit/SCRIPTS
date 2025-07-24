class ReviewResponse {
  final bool successful;
  final String message;
  final ReviewData data;

  ReviewResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      successful: json['successful'],
      message: json['message'],
      data: ReviewData.fromJson(json['data']),
    );
  }
}

class ReviewData {
  final List<Review> reviews;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  ReviewData({
    required this.reviews,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      reviews: (json['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}

class Review {
  final int id;
  final String comment;
  final int rate;
  final String createdAt;
  final bool yourReview;
  final Student student;

  Review({
    required this.id,
    required this.comment,
    required this.rate,
    required this.createdAt,
    required this.yourReview,
    required this.student,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
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
  final String image;

  Student({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
