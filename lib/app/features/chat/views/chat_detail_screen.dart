import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_detail_view_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});
  final ChatDetailViewModel controller = Get.find();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(controller: controller),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final reverseData = controller.messages.reversed.toList();
                  final message = reverseData[index];
                  final isMe = message.senderId == controller.userId;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: context.getWidth * 0.8,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content ?? '--:--',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _formatTime(message.timestamp ?? DateTime.now()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final isToday =
        time.day == now.day && time.month == now.month && time.year == now.year;
    return isToday
        ? DateFormat('HH:mm').format(time)
        : DateFormat('dd/MM').format(time);
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Nhập tin nhắn...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                controller.sendMessage(_messageController.text);
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  ChatAppBar({super.key, required this.controller});

  final ChatDetailViewModel controller;
  Color foregroundColor = AppColor.white;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: foregroundColor),
        onPressed: () => Get.back(),
      ),
      title: FittedBox(
        child: Row(
          children: [
            CustomAvatar(
              image: controller.userModel.avatar,
              size: 35,
              showBorder: false,
            ),
            const SizedBox(width: 10),
            Text(
              controller.userModel.name ?? 'Không tên',
              style: AppStyle.bold16.copyWith(color: foregroundColor),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.call, color: foregroundColor),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam, color: foregroundColor),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
