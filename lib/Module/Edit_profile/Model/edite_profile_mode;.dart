class UserResponse {
  final bool status;
  final User user;

  UserResponse({
    required this.status,
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'] ?? false,
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String image;
  final String gitHubAccount;
  final String bio;
  final String lastOnline;
  final String role;
  final String joined;
  final String age;
  final int points;
  final String level;
  final int currentStreak;
  final int completedCourses;
  final int completedLearningPaths;
  final int isFriend;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      gitHubAccount: json['gitHub_account'] ?? '',
      bio: json['bio'] ?? '',
      lastOnline: json['last_online'] ?? '',
      role: json['role'] ?? '',
      joined: json['joined'] ?? '',
      age: json['age'] ?? '',
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
