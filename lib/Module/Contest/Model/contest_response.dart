class ContestsResponse {
  final bool status;
  final List<Contest> contests;
  final Meta meta;

  ContestsResponse({
    required this.status,
    required this.contests,
    required this.meta,
  });

  factory ContestsResponse.fromJson(Map<String, dynamic> json) {
    return ContestsResponse(
      status: json['status'],
      contests: List<Contest>.from(
        json['contests'].map((x) => Contest.fromJson(x)),
      ),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Contest {
  final int id;
  final String name;
  final int time;
  final String description;
  final String type;
  final String level;
  final String status;
  final String startAt;
  final int teacherId;

  Contest({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    required this.type,
    required this.level,
    required this.status,
    required this.startAt,
    required this.teacherId,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'],
      name: json['name'],
      time: json['time'],
      description: json['description'],
      type: json['type'],
      level: json['level'],
      status: json['status'],
      startAt: json['start_at'],
      teacherId: json['teacher_id'],
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
