import 'package:equatable/equatable.dart';
import 'package:lms/Module/Course_content/Model/CommentModel/comment_response.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

/// ---------- Base States ----------
class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {}

class CommentError extends CommentState {
  final String message;
  const CommentError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Add Comment ----------
class AddCommentLoading extends CommentState {}

class AddCommentSuccess extends CommentState {}

class AddCommentError extends CommentState {
  final String message;
  const AddCommentError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddCommentRequired extends CommentState {
  final String message;
  const AddCommentRequired({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Update Comment ----------
class UpdateCommentLoading extends CommentState {}

class UpdateCommentSuccess extends CommentState {}

class UpdateCommentError extends CommentState {
  final String message;
  const UpdateCommentError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Delete Comment ----------
class DeleteCommentLoading extends CommentState {}

class DeleteCommentSuccess extends CommentState {}

class DeleteCommentError extends CommentState {
  final String message;
  const DeleteCommentError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Like Comment ----------
class LikeCommentLoading extends CommentState {}

class LikeCommentSuccess extends CommentState {}

class LikeCommentError extends CommentState {
  final String message;
  const LikeCommentError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ---------- Add Reply ----------
class AddReplyLoading extends CommentState {}

class AddReplySuccess extends CommentState {}

class AddReplyError extends CommentState {
  final String message;
  const AddReplyError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ExpandedState extends CommentState {}
class NotExpandedState extends CommentState {}
class CommentLikesUpdated extends CommentState {}
class ReplyModeState extends CommentState {
  final CommentModel parentComment;
  ReplyModeState(this.parentComment);
}
class ExitReplyModeState extends CommentState {
 
}