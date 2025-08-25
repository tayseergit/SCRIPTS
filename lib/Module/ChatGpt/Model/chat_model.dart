class ChatResponse {
  final bool status;
  final List<MessageModel> messages;

  ChatResponse({
    required this.status,
    required this.messages,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      status: json['status'] ?? false,
      messages: (json['messages'] as List? ?? [])
          .map((msg) => MessageModel.fromJson(msg))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'messages': messages.map((msg) => msg.toJson()).toList(),
    };
  }
}

class MessageModel {
  final String message;
  final int fromBot;

  MessageModel({
    required this.message,
    required this.fromBot,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'] ?? '',
      fromBot: json['fromBot'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'fromBot': fromBot,
    };
  }
}
