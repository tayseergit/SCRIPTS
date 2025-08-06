class TeacherContestModel {
  final bool status;
  final List<TeacherContestData> contests;
  final MetaData meta;

  TeacherContestModel({
    required this.status,
    required this.contests,
    required this.meta,
  });

  factory TeacherContestModel.fromJson(Map<String, dynamic> json) {
    return TeacherContestModel(
      status: json['status'] ?? false,
      contests: (json['contests'] as List)
          .map((e) => TeacherContestData.fromJson(e))
          .toList(),
      meta: MetaData.fromJson(json['meta']),
    );
  }
}

class TeacherContestData {
  final int id;
  final String name;
  final int time;
  final String description;
  final String type;
  final String level;
  final String status;
  final String startAt;
  final String requestStatus;
  final int studentsCount;
  final int teacherId;

  TeacherContestData({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    required this.type,
    required this.level,
    required this.status,
    required this.startAt,
    required this.requestStatus,
    required this.studentsCount,
    required this.teacherId,
  });

  factory TeacherContestData.fromJson(Map<String, dynamic> json) {
    return TeacherContestData(
      id: json['id'],
      name: json['name'],
      time: json['time'],
      description: json['description'],
      type: json['type'],
      level: json['level'],
      status: json['status'],
      startAt: json['start_at'],
      requestStatus: json['request_status'],
      studentsCount: json['students_count'],
      teacherId: json['teacher_id'],
    );
  }
}



class MetaData {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  MetaData({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
