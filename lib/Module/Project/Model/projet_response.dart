class ProjectsResponse {
  final bool status;
  final List<ProjectModel> data;
  final Meta meta;

  ProjectsResponse({
    required this.status,
    required this.data,
    required this.meta,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      status: json['status'],
      data: List<ProjectModel>.from(
        (json['projects'] ?? []).map((x) => ProjectModel.fromJson(x)),
      ),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class ProjectModel {
  final int id;
  final String title;
  final int userId;
  final String description;
  final dynamic technologies;
  final Links? links; // <-- changed from dynamic to Links?
  final int likes;
  final String status;
  final int tagId;
  final String? createdAt;
  final String? updatedAt;
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
      links: (json['links'] != null && json['links'] is Map)
          ? Links.fromJson(json['links'])
          : null,
      likes: json['likes'],
      status: json['status'],
      tagId: json['tag_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userName: json['user_name'],
      tagName: json['tag_name'],
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

class Links {
  final String? gitHubUrl;
  final String? demo;
  final String? steam;

  Links({this.gitHubUrl, this.demo, this.steam});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      gitHubUrl: json['gitHub_url'],
      demo: json['demo'],
      steam: json['steam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gitHub_url': gitHubUrl,
      'demo': demo,
      'steam': steam,
    };
  }
}
