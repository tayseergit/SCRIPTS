// contest_history_model.dart
import 'dart:convert';

/// ───────────────────────── Contest ─────────────────────────
class Contest {
  final int id;
  final String name;
  final DateTime date;
  final int? rank; // nullable
  final int? points; // nullable
  final String type; // e.g. "programming", "quiz"

  const Contest({
    required this.id,
    required this.name,
    required this.date,
    this.rank,
    this.points,
    required this.type,
  });

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        id: json['id'] as int,
        name: json['name'] as String,
        date: DateTime.parse(json['date'] as String),
        rank: json['rank'] != null ? json['rank'] as int : null,
        points: json['points'] != null ? json['points'] as int : null,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'rank': rank,
        'points': points,
        'type': type,
      };
}

/// ───────────────────────── Meta (pagination) ───────────────
class Meta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current_page'] as int,
        lastPage: json['last_page'] as int,
        perPage: json['per_page'] as int,
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
      };
}

/// ───────────────────────── Root response ───────────────────
class ContestResponse {
  final bool status;
  final int contestsCount;
  final int totalPoints;
  final List<Contest> contests;
  final Meta meta;

  const ContestResponse({
    required this.status,
    required this.contestsCount,
    required this.totalPoints,
    required this.contests,
    required this.meta,
  });

  factory ContestResponse.fromJson(Map<String, dynamic> json) =>
      ContestResponse(
        status: json['status'] as bool,
        contestsCount: json['contests_count'] as int,
        totalPoints: json['total_points'] as int,
        contests: (json['contests'] as List<dynamic>)
            .map((e) => Contest.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'contests_count': contestsCount,
        'total_points': totalPoints,
        'contests': contests.map((e) => e.toJson()).toList(),
        'meta': meta.toJson(),
      };

  // ── Convenience helpers for raw JSON strings ──
  static ContestResponse fromRawJson(String source) =>
      ContestResponse.fromJson(jsonDecode(source));

  String toRawJson() => jsonEncode(toJson());
}
