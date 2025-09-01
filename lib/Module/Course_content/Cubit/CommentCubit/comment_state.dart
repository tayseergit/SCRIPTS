import 'package:equatable/equatable.dart';
import 'package:lms/Module/Course_content/Model/CommentModel/comment_response.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}
abstract class CommentErrorState extends CommentState {
  final String message;
  const CommentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Base States ----------
class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {}

class CommentError extends CommentErrorState {
  const CommentError({required super.message});
}

/// ---------- Add Comment ----------
class AddCommentLoading extends CommentState {}

class AddCommentSuccess extends CommentState {}

class AddCommentError extends CommentErrorState {
  const AddCommentError({required super.message});
}
class AddCommentRequired extends CommentState {
  final String message;
  const AddCommentRequired({required this.message});
}

/// ---------- Update Comment ----------
class UpdateCommentLoading extends CommentState {}

class UpdateCommentSuccess extends CommentState {}

class UpdateCommentError extends CommentErrorState {
  const UpdateCommentError({required super.message});
}

/// ---------- Delete Comment ----------
class DeleteCommentLoading extends CommentState {}

class DeleteCommentSuccess extends CommentState {}


class DeleteCommentError extends CommentErrorState {
  const DeleteCommentError({required super.message});
}

/// ---------- Like Comment ----------
class LikeCommentLoading extends CommentState {}

class LikeCommentSuccess extends CommentState {}


class LikeCommentError extends CommentErrorState {
  const LikeCommentError({required super.message});
}

/// ---------- Add Reply ----------
class AddReplyLoading extends CommentState {}

class AddReplySuccess extends CommentState {}

class AddReplyError extends CommentErrorState {
  const AddReplyError({required super.message});
}

class ExpandedState extends CommentState {}

class NotExpandedState extends CommentState {}

class CommentLikesUpdated extends CommentState {}

class ReplyModeState extends CommentState {
  final CommentModel parentComment;
  ReplyModeState(this.parentComment);
}

class ExitReplyModeState extends CommentState {}
