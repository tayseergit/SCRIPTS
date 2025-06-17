class UserAuthModel {
  final bool message;
  final int userId;
  final String token;
  final String role;

  UserAuthModel.UserAuthModel({
    required this.message,
    required this.userId,
    required this.token,
    required this.role,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel.UserAuthModel(
      message: json['message'],
      userId: json['user_id'],
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user_id': userId,
      'token': token,
      'role': role,
    };
  }
}
