import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/gen/assets.gen.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chatViewModel});
  final ChatViewModel chatViewModel;

  @override
  Widget build(BuildContext context) {
    return chatViewModel.conversationModels.isEmpty
        ? _chatNotFound()
        : Obx(
          () => ListView.builder(
            itemCount: chatViewModel.conversationModels.length,
            itemBuilder: (context, index) {
              final conversation = chatViewModel.conversationModels[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      conversation.friend?.avatar != null
                          ? NetworkImage(conversation.friend!.avatar!)
                          : AssetImage(Assets.images.avatarNull.path)
                              as ImageProvider,
                ),
                title: Text(conversation.friend?.name ?? ''),
                subtitle: Text(conversation.lastMessage!.content ?? ''),
                onTap:
                    () => Get.toNamed(
                      AppRoutes.CHATDETAIL,
                      arguments: conversation.friend,
                    ),
              );
            },
          ),
        );
  }

  Widget _chatNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColor.secondary,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'No conversations yet',
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start chatting with your friends',
            style: TextStyle(color: AppColor.textSecondary, fontSize: 16),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
