// ignore_for_file: file_names

class Urls {
  static String ip = "https://lms-master-ikaitb.laravel.cloud";
  static String baseUrl = "";

  static String teacher = '$baseUrl/users';
  static String update = '$baseUrl/me/update';
  static String notification = '$baseUrl/notifications';
  static String getChat = '$baseUrl/agent';
  static String chatSend = '$baseUrl/agent/send';
  static String deletAi = '$baseUrl/agent';

  static teacherProfile(int id) {
    return '$baseUrl/users/$id';
  }

  static teacherCourses(int id) {
    return '$baseUrl/users/$id/created_courses';
  }

  static teacherLearnPath(int id) {
    return '$baseUrl/users/$id/created_learning_paths';
  }

  static teacherContest(int id) {
    return '$baseUrl/users/$id/created_contest';
  }

  static getAllFriend(int id) {
    return '$baseUrl/users/$id/friends';
  }

  static deletFriend(int id) {
    return '$baseUrl/friends/$id';
  }

  static learnPathInfo(int id) {
    return '$baseUrl/learningPath/$id';
  }

  static learnPathInfocourse(int id) {
    return '$baseUrl/learningPath/$id/courses';
  }

  static feachLeaderBoard(int id, {bool justFriends = false}) {
    return '$baseUrl/contests/$id/standing?justFriends=${justFriends ? 1 : 0}';
  }
}
