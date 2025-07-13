class ProjectModel {
  final int id;
  final String title;
  final int userId;
  final String description;
  final String? technologies;
  final String? links;
  final int likes;
  final String status;
  final int tagId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final String tagName;

  ProjectModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.description,
    this.technologies,
    this.links,
    required this.likes,
    required this.status,
    required this.tagId,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.tagName,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      description: json['description'],
      technologies: json['technologies'],
      links: json['links'],
      likes: json['likes'],
      status: json['status'],
      tagId: json['tag_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userName: json['user_name'],
      tagName: json['tag_name'],
    );
  }
}
