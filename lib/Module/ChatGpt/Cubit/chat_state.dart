import 'package:lms/Module/ChatGpt/Model/chat_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoding extends ChatState {}
class UnAuth extends ChatState {}

class ChatDeleteSuccess extends ChatState {
  final ChatResponse chatResponse;
  ChatDeleteSuccess({required this.chatResponse});
}


class ChatLoaded extends ChatState {
  final ChatResponse chatResponse;
  ChatLoaded({required this.chatResponse});
}

// حالة جديدة لإرسال الرسالة
class ChatSending extends ChatState {
  final ChatResponse chatResponse;
  ChatSending({required this.chatResponse});
}

class ChatError extends ChatState {
  final String message;
  ChatError({
    required this.message,
  });
}