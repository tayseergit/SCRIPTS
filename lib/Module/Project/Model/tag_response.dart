class TagsResponse {
  final bool status;
  final List<TagModel> tags;

  TagsResponse({
    required this.status,
    required this.tags,
  });

  factory TagsResponse.fromJson(Map<String, dynamic> json) {
    return TagsResponse(
      status: json['status'],
      tags: List<TagModel>.from(
        (json['tags'] ?? []).map((x) => TagModel.fromJson(x)),
      ),
    );
  }
}

class TagModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  TagModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
