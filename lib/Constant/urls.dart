// ignore_for_file: file_names

class Urls {
  static String ip = "192.168.1.5";
  static String baseUrl = "";

  static String teacher = '$baseUrl/users';

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
}
