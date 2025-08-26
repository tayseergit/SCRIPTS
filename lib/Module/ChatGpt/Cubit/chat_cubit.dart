import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/ChatGpt/Cubit/chat_state.dart';
import 'package:lms/Module/ChatGpt/Model/chat_model.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  ChatResponse? _chatResponse;

  Future<void> fetchChatMessages() async {
    emit(ChatLoding());
    print("📡 [fetchChatMessages] Started...");

    try {
      final token = CacheHelper.getToken();
      final userId = CacheHelper.getData(key: 'user_id');
      print("🌍 [DeletFriend] إرسال طلب DELETE إلى: ${Urls.getChat}");
      print("🔑 [fetchChatMessages] Token: $token");

      if (token == null || userId == null) {
        print("❌ [fetchChatMessages] No token found, user not authenticated.");
        emit(ChatError(message: 'User is not authenticated'));
        return;
      }

      print("🌍 [fetchChatMessages] Sending request to: ${Urls.getChat}");
      final response = await DioHelper.getData(
        url: Urls.getChat,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print("🌍 [fetchChatMessages] Sending request to: ${Urls.getChat}");
      print("📥 [fetchChatMessages] Response status: ${response.statusCode}");
      print("📥 [fetchChatMessages] Response data: ${response.data}");

      if (response.statusCode == 200) {
        final chat = ChatResponse.fromJson(response.data);
        _chatResponse = chat;
        print("✅ [fetchChatMessages] Messages loaded: ${chat.messages.length}");
        emit(ChatLoaded(chatResponse: chat));
      } else {
        print(
            "❌ [fetchChatMessages] Failed with status: ${response.statusCode}");
        emit(ChatError(
          message: 'Failed with status code: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("🔥 [fetchChatMessages] DioException: ${e.message}");
      emit(ChatError(message: 'Dio error: ${e.message}'));
    } catch (e, stacktrace) {
      print("🔥 [fetchChatMessages] Unknown error: $e");
      print("📝 [fetchChatMessages] Stacktrace: $stacktrace");
      emit(ChatError(message: 'Unknown error: $e'));
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    print("📤 [sendMessage] Sending message: $message");

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';

      if (token.isEmpty) {
        emit(ChatError(message: 'User is not authenticated'));
        return;
      }

      addLocalMessage(message, 0);

      emit(ChatSending(chatResponse: _chatResponse!));

      print("🌍 [sendMessage] Sending POST request to: /api/agent/send");

      final response = await DioHelper.postFormData(
        url: Urls.chatSend,
        postData: FormData.fromMap({'message': message}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📥 [sendMessage] Response status: ${response.statusCode}");
      print("📥 [sendMessage] Response data: ${response.data}");

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == true) {
          final botResponse = responseData['output'] ?? 'No response from bot';
          addLocalMessage(botResponse, 1);
          print("✅ [sendMessage] Bot response added: $botResponse");
        } else {
          emit(ChatError(message: 'Failed to get bot response'));
        }
      } else {
        emit(ChatError(
          message: 'Failed to send message. Status: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      print("🔥 [sendMessage] DioException: ${e.message}");
      emit(ChatError(message: 'Network error: ${e.message}'));
    } catch (e, stacktrace) {
      print("🔥 [sendMessage] Unknown error: $e");
      print("📝 [sendMessage] Stacktrace: $stacktrace");
      emit(ChatError(message: 'Failed to send message: $e'));
    }
  }

  void addLocalMessage(String message, int fromBot) {
    final updatedMessages = List<MessageModel>.from(
      _chatResponse?.messages ?? [],
    )..add(MessageModel(message: message, fromBot: fromBot));

    _chatResponse = ChatResponse(
      status: true,
      messages: updatedMessages,
    );

    emit(ChatLoaded(chatResponse: _chatResponse!));
  }

  Future<void> DeletFriend() async {
    try {
      emit(ChatLoding());

      final token = CacheHelper.getData(key: 'token') ?? '';
      if (token.isEmpty) {
        emit(ChatError(message: 'User is not authenticated'));
        return;
      }

      print("🌍 [DeletFriend] Sending DELETE request to: ${Urls.deletAi}");

      final response = await DioHelper.deleteData(
        url: Urls.deletAi,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📥 [DeletFriend] Response status: ${response.statusCode}");
      print("📥 [DeletFriend] Response data: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == true) {
        _chatResponse = ChatResponse(status: true, messages: []);
        emit(ChatLoaded(chatResponse: _chatResponse!));
      } else {
        emit(ChatError(
          message: response.data['message'] ?? 'Failed to delete chat',
        ));
      }
    } catch (e) {
      print("🔥 [DeletFriend] Exception: $e");
      emit(ChatError(message: 'An error occurred while deleting chat'));
    }
  }
}
