import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/ChatGpt/Cubit/chat_cubit.dart';
import 'package:lms/Module/ChatGpt/Cubit/chat_state.dart';
import 'package:lms/Module/ChatGpt/Model/chat_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (_) => ChatCubit()..fetchChatMessages(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded && state.chatResponse.messages.isEmpty) {
            CustomSnackbar.show(
              context: context,
              fillColor: appColors.ok,
              message: "Clear Successful",
            );
          }

          if (state is ChatError) {
            CustomSnackbar.show(
              context: context,
              fillColor: appColors.red,
              message: state.message,
            );
          }
          if (state is UnAuth) {
            showNoAuthDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              title: AuthText(
                text: 'SCRIPTS AI',
                size: 22,
                color: appColors.mainText,
                fontWeight: FontWeight.w600,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: appColors.red,
                  ),
                  onPressed: () {
                    context.read<ChatCubit>().DeletFriend();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is ChatLoding) {
                        return Center(
                          child: SizedBox(
                            height: 80.h,
                            child: Loading(height: 50.h, width: 50.w),
                          ),
                        );
                      }

                      if (state is ChatLoaded ||
                          state is ChatSending ||
                          state is ChatDeleteSuccess) {
                        final chatResponse = state is ChatLoaded
                            ? state.chatResponse
                            : (state as ChatSending).chatResponse;

                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.all(12.r),
                                itemCount: chatResponse.messages.length,
                                itemBuilder: (context, index) {
                                  final MessageModel msg =
                                      chatResponse.messages[index];
                                  final bool isUser = msg.fromBot == 0;

                                  return Align(
                                    alignment: isUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      padding: EdgeInsets.all(12.r),
                                      decoration: BoxDecoration(
                                        color: isUser
                                            ? appColors.primary
                                            : appColors.lightGray,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: AuthText(
                                        text: msg.message,
                                        size: 16,
                                        maxLines: 10000,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (state is ChatSending)
                              Container(
                                padding: EdgeInsets.all(12.r),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    AuthText(
                                      text: "Bot is typing...",
                                      color: appColors.secondText,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        );
                      }

                      if (state is ChatError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: appColors.red,
                                size: 48.sp,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        );
                      }

                      return Center(child: Text("No messages yet..."));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      final bool isSending = state is ChatSending;

                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              enabled: !isSending,
                              decoration: InputDecoration(
                                hintText: isSending
                                    ? "Sending..."
                                    : "Type your question...",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r)),
                                  borderSide:
                                      BorderSide(color: appColors.primary),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r)),
                                  borderSide: BorderSide(
                                      color: appColors.primary, width: 2),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r)),
                                  borderSide:
                                      BorderSide(color: appColors.primary),
                                ),
                              ),
                              onSubmitted: (text) {
                                final text = controller.text.trim();
                                if (text.isEmpty) return;
                                context.read<ChatCubit>().sendMessage(text);
                                controller.clear();
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isSending ? Icons.hourglass_empty : Icons.send,
                              color: isSending
                                  ? appColors.secondText
                                  : appColors.primary,
                            ),
                            onPressed: isSending
                                ? null
                                : () {
                                    final text = controller.text.trim();
                                    if (text.isEmpty) return;
                                    context.read<ChatCubit>().sendMessage(text);
                                    controller.clear();
                                  },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
