class FriendsResponse {
  final bool status;
  final int total;
  final List<Friend> friends;
  final Meta meta;

  FriendsResponse( {
    required this.total,
    required this.status,
    required this.friends,
    required this.meta,
  });

  factory FriendsResponse.fromJson(Map<String, dynamic> json) {
    return FriendsResponse(
      total: json['total'],
      status: json['status'],
      friends: List<Friend>.from(json['friends'].map((x) => Friend.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total':total,
      'status': status,
      'friends': friends.map((x) => x.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class Friend {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String gitHubAccount;
  final String bio;
  final String lastOnline;
  final String role;
  final String joined;
  final int age;
  final int points;
  final String level;
  final int currentStreak;
  final int completedCourses;
  final int completedLearningPaths;
  final int? isFriend;

  Friend({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.gitHubAccount,
    required this.bio,
    required this.lastOnline,
    required this.role,
    required this.joined,
    required this.age,
    required this.points,
    required this.level,
    required this.currentStreak,
    required this.completedCourses,
    required this.completedLearningPaths,
    required this.isFriend,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      gitHubAccount: json['gitHub_account'],
      bio: json['bio'],
      lastOnline: json['last_online'],
      role: json['role'],
      joined: json['joined'],
      age: json['age'],
      points: json['points'],
      level: json['level'],
      currentStreak: json['current_streak'],
      completedCourses: json['completed_courses'],
      completedLearningPaths: json['completed_learning_paths'],
      isFriend: json['is_friend'],
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
