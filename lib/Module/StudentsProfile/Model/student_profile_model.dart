import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  final int age;
  final int? balance;
  final int points;
  final int currentStreak;
  final int completedCourses;
  final int completedLearningPaths;
  final bool blocked;
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
    required this.age,
    this.balance,
    required this.points,
    required this.currentStreak,
    required this.completedCourses,
    required this.completedLearningPaths,
    required this.blocked,
    required this.isFriend,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    String? rawImage = json['image'];
    String? processedImage;

    final ip = dotenv.env['API_IP'];
    final port = dotenv.env['API_PORT'];

    if (rawImage != null &&
        (rawImage.contains('localhost') || rawImage.contains('127.0.0.1'))) {
      Uri oldUri = Uri.parse(rawImage);
      String newBase = 'http://$ip:$port';

      String toReplace = oldUri.hasPort && oldUri.port != 80
          ? '${oldUri.scheme}://${oldUri.host}:${oldUri.port}'
          : '${oldUri.scheme}://${oldUri.host}';

      processedImage = rawImage.replaceFirst(toReplace, newBase);
    } else {
      processedImage = rawImage;
    }

    return StudentProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: processedImage,
      gitHubAccount: json['gitHub_account'],
      bio: json['bio'],
      lastOnline: json['last_online'],
      role: json['role'],
      level: json['level'],
      joined: json['joined'],
      age: json['age'],
      balance: json['balance'],
      points: json['points'],
      currentStreak: json['current_streak'],
      completedCourses: json['completed_courses'],
      completedLearningPaths: json['completed_learning_paths'],
      blocked: json['blocked'],
      isFriend: json['is_friend'] == 1,
    );
  }
}
