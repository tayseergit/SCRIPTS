class UserModel {
  final bool status;
  final UserData user;

  UserModel({
    required this.status,
    required this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] ?? false,
      user: UserData.fromJson(json['user']),
    );
  }
}

class UserData {
  final int id;
  final String? name;
  final String? email;
  final String? image;
  final String? gitHubAccount;
  final String? bio;
  final String? lastOnline;
  final String? role;
  final String? joined;
  final int? age;
  final int? created_courses;
  final int? created_paths;
  final int? created_contests;
  final int? balance;

  UserData({
    required this.id,
    this.name,
    this.email,
    this.image,
    this.gitHubAccount,
    this.bio,
    this.lastOnline,
    this.role,
    this.joined,
    this.age,
    this.created_courses,
    this.created_paths,
    this.created_contests,
    this.balance,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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
      created_courses: json['created_courses'],
      created_paths: json['created_paths'],
      balance: json['balance'],
      created_contests: json['created_contests'],
    );
  }
}
