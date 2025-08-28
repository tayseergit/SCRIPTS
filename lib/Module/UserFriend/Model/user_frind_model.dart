class FriendsResponse {
  final bool status;
  final int total;
  final List<Friend> friends;
  final Meta meta;

  FriendsResponse({
    required this.status,
    required this.total,
    required this.friends,
    required this.meta,
  });

  factory FriendsResponse.fromJson(Map<String, dynamic> json) {
    return FriendsResponse(
      status: json['status'] ?? false,
      total: json['total'] ?? 0,
      friends: (json['friends'] as List<dynamic>?)
              ?.map((x) => Friend.fromJson(x))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total': total,
      'friends': friends.map((x) => x.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class Friend {
  final int id;
  final String name;
  final String? email;
  final String? image;
  final String? gitHubAccount;
  final String? bio;
  final String? lastOnline;
  final String? role;
  final String? joined;
  final int? age;
  final int points;
  final String level;
  final int currentStreak;
  final int completedCourses;
  final int completedLearningPaths;
  final int isFriend;

  Friend({
    required this.id,
    required this.name,
    this.email,
    this.image,
    this.gitHubAccount,
    this.bio,
    this.lastOnline,
    this.role,
    this.joined,
    this.age,
    required this.points,
    required this.level,
    required this.currentStreak,
    required this.completedCourses,
    required this.completedLearningPaths,
    required this.isFriend,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      image: json['image'],
      gitHubAccount: json['gitHub_account'],
      bio: json['bio'],
      lastOnline: json['last_online'],
      role: json['role'],
      joined: json['joined'],
      age: json['age'],
      points: json['points'] ?? 0,
      level: json['level'] ?? '',
      currentStreak: json['current_streak'] ?? 0,
      completedCourses: json['completed_courses'] ?? 0,
      completedLearningPaths: json['completed_learning_paths'] ?? 0,
      isFriend: json['is_friend'] ?? 0,
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
      'points': points,
      'level': level,
      'current_streak': currentStreak,
      'completed_courses': completedCourses,
      'completed_learning_paths': completedLearningPaths,
      'is_friend': isFriend,
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
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      total: json['total'] ?? 0,
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
