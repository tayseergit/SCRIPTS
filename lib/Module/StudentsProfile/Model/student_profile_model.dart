class StudentProfileModel {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String? gitHubAccount;
  final String? bio;
  final String lastOnline;
  final String role;
  final String level;
  final String joined;
  final int points;
  final int completedCourses;
  final int completedLearningPaths;
  final bool isFriend;

  StudentProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.gitHubAccount,
    this.bio,
    required this.lastOnline,
    required this.role,
    required this.level,
    required this.joined,
    required this.points,
    required this.completedCourses,
    required this.completedLearningPaths,
    required this.isFriend,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      gitHubAccount: json['gitHub_account'] ?? '',
      bio: json['bio'] ?? '',
      lastOnline: json['last_online'],
      role: json['role'],
      level: json['level'],
      joined: json['joined'],
      points: json['points'],
      completedCourses: json['completed_courses'],
      completedLearningPaths: json['completed_learning_paths'],
      isFriend: json['is_friend'] == 1,
    );
  }
}
