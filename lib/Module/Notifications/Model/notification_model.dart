class NotificationResponse {
  final bool successful;
  final String message;
  final List<NotificationData> data;

  NotificationResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      successful: json['successful'] ?? false,
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>)
          .map((e) => NotificationData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "successful": successful,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class NotificationData {
  final int id;
  final String title;
  final String message;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationData({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      message: json['message'] ?? "",
      userId: json['user_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "message": message,
      "user_id": userId,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
