class AchievementResponse { 
  final bool status;
  final List<Achievement> achievements;
  final Meta meta;

  AchievementResponse({
    required this.status,
    required this.achievements,
    required this.meta,
  });

  factory AchievementResponse.fromJson(Map<String, dynamic> json) {
    return AchievementResponse(
      status: json['status'],
      achievements: (json['achievements'] as List)
          .map((e) => Achievement.fromJson(e))
          .toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Achievement {
  final int id;
  final String name;
  final String? image;
  final String description;
  final String achieveDate;

  Achievement({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.achieveDate,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      achieveDate: json['achieve_date'],
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
