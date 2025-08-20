class CommentsResponse {
  final bool successful;
  final String message;
  final CommentData data;

  CommentsResponse({
    required this.successful,
    required this.message,
    required this.data,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) {
    return CommentsResponse(
      successful: json['successful'] ?? false,
      message: json['message'] ?? '',
      data: CommentData.fromJson(json['data']),
    );
  }
}

class CommentData {
  final List<CommentModel> comments;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  CommentData({
    required this.comments,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      comments: (json['comments'] as List<dynamic>)
          .map((c) => CommentModel.fromJson(c))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      hasMorePages: json['hasMorePages'] ?? false,
    );
  }
}

class CommentModel {
  final int id;
  final String text;
    int likes;
    bool likedByMe;
    bool isMine;
  final int userId;
  final String userName;
  final String userImage;
  final String userRole;
  final String createdAt;
  final int repliesCount;
  final List<CommentModel> replies; // ممكن تكون nested

  CommentModel({
    required this.id,
    required this.text,
    required this.likes,
    required this.likedByMe,
    required this.isMine,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userRole,
    required this.createdAt,
    required this.repliesCount,
    required this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      likes: json['likes'] ?? 0,
      likedByMe: json['liked_by_me'] ?? false,
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      userImage: json['user_image'] ?? '',
      userRole: json['user_role'] ?? '',
      createdAt: json['created_at'] ?? '',
      isMine: json['is_mine'] ?? false,
      repliesCount: json['replies_count'] ?? 0,
      replies: (json['replies'] as List<dynamic>)
          .map((r) => CommentModel.fromJson(r))
          .toList(),
    );
  }
}
