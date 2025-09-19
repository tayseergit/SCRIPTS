import 'package:lms/Module/UserFriend/Model/user_frind_model.dart';

abstract class UserFriendState {}

class UserFriendInitial extends UserFriendState {}

class UserFriendSuccess extends UserFriendState {
  final FriendsResponse friendsResponse;

  UserFriendSuccess({required this.friendsResponse});
}

class UserFriendLoading extends UserFriendState {}

class UserFriendError extends UserFriendState {
  final String masseg;
  UserFriendError({required this.masseg});
}

class UserFriendDeletSuccess extends UserFriendState {}
class UnAuth extends UserFriendState {}
