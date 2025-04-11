import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/utils/date_format.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';
import 'package:momentsy/gen/assets.gen.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chatViewModel});
  final ChatViewModel chatViewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          chatViewModel.conversationModels.isEmpty
              ? _chatNotFound()
              : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: space12,
                ).copyWith(top: space12),
                itemCount: chatViewModel.conversationModels.length,
                separatorBuilder: (_, __) => const SizedBox(height: space8),
                itemBuilder: (context, index) {
                  final conversation = chatViewModel.conversationModels[index];
                  final friend = conversation.friend;
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.CHATDETAIL, arguments: friend);
                    },
                    splashColor: AppColor.primary.withOpacity(0.1),
                    highlightColor: AppColor.primary.withOpacity(0.05),
                    child: Row(
                      children: [
                        _buildAvatar(friend),
                        const SizedBox(width: space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend?.name ?? 'Không tên',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      conversation.lastMessage?.content ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyle.regular14.copyWith(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (conversation.lastMessage?.timestamp != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              DateFormatUtils.formatTimeChat(
                                conversation.lastMessage!.timestamp!,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildAvatar(friend) {
    return CustomAvatar(imageUrl: friend?.avatar, size: 56, showBorder: false);
  }

  Widget _chatNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              Assets.images.avatarNull.path,
              width: 80,
              height: 80,
              color: AppColor.primary, // Xanh Messenger
            ),
          ),
          const SizedBox(height: 12),
          Text('Chưa có tin nhắn', style: AppStyle.bold18),
          const SizedBox(height: 8),
          Text('Bắt đầu trò chuyện với bạn bè!', style: AppStyle.bold16),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF006AFF), // Xanh Messenger
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Tìm bạn bè',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
