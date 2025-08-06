class UsersResponse {
  final bool status;
  final String message;
  final List<TeacherModel> users;
  final Meta meta;

  UsersResponse({
    required this.status,
    required this.message,
    required this.users,
    required this.meta,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      status: json['status'],
      message: json['message'],
      users: List<TeacherModel>.from(json['users'].map((x) => TeacherModel.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'users': users.map((x) => x.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}


class TeacherModel {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String gitHubAccount;
  final String bio;
  final String lastOnline;
  final String role;
  final String joined;
  final int? age;
  final int createdCourses;
  final int createdPaths;
  final int createdContests;

  TeacherModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.gitHubAccount,
    required this.bio,
    required this.lastOnline,
    required this.role,
    required this.joined,
    this.age,
    required this.createdCourses,
    required this.createdPaths,
    required this.createdContests,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      gitHubAccount: json['gitHub_account'] ?? '',
      bio: json['bio'] ?? '',
      lastOnline: json['last_online'] ?? '',
      role: json['role'] ?? '',
      joined: json['joined'] ?? '',
      age: json['age'], // nullable
      createdCourses: json['created_courses'] ?? 0,
      createdPaths: json['created_paths'] ?? 0,
      createdContests: json['created_contests'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'gitHub_account': gitHubAccount,
      'bio': bio,
      'last_online': lastOnline,
      'role': role,
      'joined': joined,
      'age': age,
      'created_courses': createdCourses,
      'created_paths': createdPaths,
      'created_contests': createdContests,
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
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
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
