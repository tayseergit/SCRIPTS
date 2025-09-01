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
      questionCount: int.tryParse(json['question_count']?.toString() ?? '0') ?? 0,
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
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      correctAnswers: int.tryParse(json['correct_answers']?.toString() ?? '0') ?? 0,
      gainedPoints: int.tryParse(json['gained_points']?.toString() ?? '0') ?? 0,
      rank: int.tryParse(json['rank']?.toString() ?? '0') ?? 0,
      image: json['image']?.toString() ?? '',
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
      currentPage: int.tryParse(json['current_page']?.toString() ?? '0') ?? 0,
      lastPage: int.tryParse(json['last_page']?.toString() ?? '0') ?? 0,
      perPage: int.tryParse(json['per_page']?.toString() ?? '0') ?? 0,
      total: int.tryParse(json['total']?.toString() ?? '0') ?? 0,
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
