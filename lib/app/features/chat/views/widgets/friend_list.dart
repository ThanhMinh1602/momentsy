import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key, required this.chatViewModel});
  final ChatViewModel chatViewModel;

  @override
  Widget build(BuildContext context) {
    final friends = chatViewModel.userModels;

    return Obx(
      () =>
          friends.isEmpty
              ? _noFriendsWidget()
              : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: space12,
                  vertical: space8,
                ),
                itemCount: friends.length,
                separatorBuilder:
                    (_, __) => Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.CHATDETAIL, arguments: friend);
                    },
                    splashColor: const Color(0xFF006AFF).withOpacity(0.1),
                    highlightColor: const Color(0xFF006AFF).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: space12,
                        horizontal: space12,
                      ),
                      child: Row(
                        children: [
                          // Avatar với chấm online
                          _buildAvatar(friend),
                          const SizedBox(width: space12),
                          // Thông tin bạn bè
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  friend.name ?? 'Không tên',
                                  style: AppStyle.bold16.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Ấn để trò chuyện',
                                  style: AppStyle.regular14.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Icon mũi tên
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildAvatar(dynamic friend) {
    return CustomAvatar(imageUrl: friend.avatar, size: 48, showBorder: false);
  }

  Widget _noFriendsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.group_outlined,
              size: 80,
              color: const Color(0xFF006AFF), // Xanh Messenger
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Chưa có bạn bè',
            style: AppStyle.bold18.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            'Tìm và kết bạn ngay!',
            style: AppStyle.regular16.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Có thể mở màn hình tìm bạn bè
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF006AFF), // Xanh Messenger
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Tìm bạn bè',
                style: AppStyle.bold16.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
