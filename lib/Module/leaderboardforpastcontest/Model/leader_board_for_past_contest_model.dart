class QuizResultModel {
  final bool status;
  final String message;
  final dynamic yourOrder;
  final int questionCount;
  final List<Studentss> students;
  final Meta meta;

  QuizResultModel({
    required this.status,
    required this.message,
    required this.yourOrder,
    required this.questionCount,
    required this.students,
    required this.meta,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      yourOrder: json['your_order'],
      questionCount: json['question_count'] ?? 0,
      students: (json['students'] as List<dynamic>?)
              ?.map((e) => Studentss.fromJson(e))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'your_order': yourOrder,
      'question_count': questionCount,
      'students': students.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class Studentss {
  final int id;
  final String name;
  final String endTime;
  final int correctAnswers;
  final int gainedPoints;
  final int rank;
  final String image;

  Studentss({
    required this.id,
    required this.name,
    required this.endTime,
    required this.correctAnswers,
    required this.gainedPoints,
    required this.rank,
    required this.image,
  });

  factory Studentss.fromJson(Map<String, dynamic> json) {
    return Studentss(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      endTime: json['end_time'] ?? '',
      correctAnswers: json['correct_answers'] ?? 0,
      gainedPoints: json['gained_points'] ?? 0,
      rank: json['rank'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'end_time': endTime,
      'correct_answers': correctAnswers,
      'gained_points': gainedPoints,
      'rank': rank,
      'image': image,
    };
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
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
