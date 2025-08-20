import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';

import 'package:lms/Module/Course_content/Cubit/CommentCubit/comment_state.dart';
import 'package:lms/Module/Course_content/Model/CommentModel/comment_response.dart';
import 'package:lms/generated/l10n.dart'; // ✅ تأكد أن هذا المسار صحيح
import 'package:meta/meta.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({required this.context}) : super(CommentInitial());
  int? videoId;
  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");
  BuildContext context;
  final userImg = CacheHelper.getData(key: "user_img");
  bool isExpanded = false;

  CommentsResponse? commentResponse;

  TextEditingController addCommentController = TextEditingController();
  int currentPage = 1;
  bool hasMorePages = true;
  bool isLoading = false;

  List<CommentModel> allComments = [];

  void reset() {
    currentPage = 1;
    hasMorePages = true;
    addCommentController.text = "";
    allComments.clear();
  }

  void toggleExpand() {
    isExpanded = !isExpanded;
    emit(ExpandedState());
    print(isExpanded);
  }

  void toggleNotExpand() {
    isExpanded = !isExpanded;
    emit(NotExpandedState());
    print(isExpanded);
  }

  void toggleLike(CommentModel comment) {
    if (comment.likedByMe) {
      comment.likedByMe = false;
      comment.likes -= 1;
    } else {
      comment.likedByMe = true;
      comment.likes += 1;
    }
    emit(CommentLikesUpdated());
  }

  void enterReplyMode(CommentModel comment) {
    emit(ReplyModeState(comment));
  }

  void exitReplyMode() {
    emit(ExitReplyModeState()); // أو أي حالة مناسبة للرجوع للوضع العادي
  }

  void deleteReply(int replyId) {
    for (var comment in allComments) {
      comment.replies.removeWhere((reply) => reply.id == replyId);
    }
  }

  /// Get All Comments
  Future<void> getAllComments() async {
    // if (!hasMorePages) return;
    emit(CommentLoading());
    try {
      DioHelper.getData(
        url: "video/$videoId/comments",
        params: {"page": currentPage},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          commentResponse = CommentsResponse.fromJson(response.data);
          print("sssssssssssscccccc");

          hasMorePages = commentResponse!.data.hasMorePages;
          if (hasMorePages) currentPage++;

          if (commentResponse!.data.comments.isNotEmpty) {
            allComments.addAll(commentResponse!.data.comments);
          }
          // print(response.statusCode);
          emit(CommentSuccess());
        } else {
          emit(CommentError(
              message:
                  response.data['message'] ?? S.of(context).error_in_server));
          print(response.data['message']);
        }
      }).catchError((error) {
        if (error is DioException) {
          final message =
              error.response?.data['message'] ?? S.of(context).error_in_server;
          emit(CommentError(message: message));
        } else {
          emit(CommentError(message: S.of(context).error_occurred));
        }
      });
    } catch (e) {
      emit(CommentError(message: S.of(context).error_occurred));
      print(e.toString());
    }
  }

  /// Add Comment
  Future<void> addComment() async {
    if (addCommentController.text.isEmpty) {
      return;
    }

    emit(AddCommentLoading());

    try {
      DioHelper.postData(
        url: "video/${videoId!}/comments",
        postData: {"text": addCommentController.text.trim()},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        print(response.data["message"]);
        if (response.statusCode == 200) {
          final newComment = CommentModel.fromJson(response.data["data"]);
          allComments.insert(0, newComment);
          addCommentController.text = "";
          print("ok");
          emit(AddCommentSuccess());
        }
        // print("adddddcommmmeeennntt");
      }).catchError((error) {
        if (error is DioException) {
          final message =
              error.response?.data['message'] ?? S.of(context).error_in_server;
          emit(AddCommentError(message: message));
        } else {
          emit(AddCommentError(message: S.of(context).error_occurred));
        }
      });
    } catch (e) {
      emit(AddCommentError(message: S.of(context).error_in_server));
    }
  }

  /// Update Comment
  Future<void> updateComment(
    BuildContext context,
    int commentId,
    String newText,
  ) async {
    emit(UpdateCommentLoading());

    DioHelper.putData(
      url: "comments/$commentId",
      putData: {"text": newText},
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(UpdateCommentSuccess());
        reset();
        getAllComments();
      } else {
        emit(UpdateCommentError(message: S.of(context).error_occurred));
      }
    }).catchError((error) {
      if (error is DioException) {
        final message =
            error.response?.data['message'] ?? S.of(context).error_in_server;
        emit(UpdateCommentError(message: message));
      } else {
        emit(UpdateCommentError(message: S.of(context).error_occurred));
      }
    });
  }

  /// Delete Comment
  Future<void> deleteComment(CommentModel commentModel, bool isReplay) async {
    emit(DeleteCommentLoading());
    print(commentModel.id);
    try {
      DioHelper.deleteData(
        url: "comments/${commentModel.id}",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        if (response.statusCode == 200) {
          if (isReplay) {
            deleteReply(commentModel.id);
          } else
            allComments.remove(commentModel);
          emit(DeleteCommentSuccess());
        } else {
          emit(DeleteCommentError(message: S.of(context).error_deleting));
        }
      }).catchError((error) {
        if (error is DioException) {
          final message =
              error.response?.data['message'] ?? S.of(context).error_in_server;
          emit(DeleteCommentError(message: message));
        } else {
          emit(DeleteCommentError(message: S.of(context).error_occurred));
        }
      });
    } catch (e) {
      emit(DeleteCommentError(message: S.of(context).error_in_server));
    }
  }

  /// Like Comment
  Future<void> likeComment(
    CommentModel commentModel,
  ) async {
    // emit(LikeCommentLoading());
    print(commentModel.id);
    try {
      DioHelper.postData(
        url: "comment/${commentModel.id}/likes",
        postData: {},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((response) {
        if (response.statusCode == 200) {
          emit(LikeCommentSuccess());
          toggleLike(commentModel);
        } else {
          emit(LikeCommentError(message: S.of(context).error_occurred));
        }
      }).catchError((error) {
        if (error is DioException) {
          final message =
              error.response?.data['message'] ?? S.of(context).error_in_server;
          emit(LikeCommentError(message: message));
        } else {
          emit(LikeCommentError(message: S.of(context).error_occurred));
        }
      });
    } catch (e) {
      emit(LikeCommentError(message: S.of(context).error_in_server));
    }
  }

  /// Add Reply to Comment
  Future<void> addReply(
    int parentCommentId,
  ) async {
    if (addCommentController.text.isEmpty) {
      emit(AddReplyError(message: S.of(context).fill_details));
      return;
    }

    emit(AddReplyLoading());

    DioHelper.postData(
      url: "video/$videoId/comments",
      postData: {
        "text": addCommentController.text,
        "comment_id": parentCommentId
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddReplySuccess());
        reset();
        getAllComments();
      } else {
        emit(AddReplyError(message: S.of(context).error_occurred));
      }
    }).catchError((error) {
      if (error is DioException) {
        final message =
            error.response?.data['message'] ?? S.of(context).error_in_server;
        emit(AddReplyError(message: message));
      } else {
        emit(AddReplyError(message: S.of(context).error_occurred));
      }
    });
  }
}
