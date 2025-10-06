import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/notification/viewmodels/notification_view_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final notifiController = Get.find<NotificationViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(
        () =>
            notifiController.friendRequests.isEmpty
                ? _noFriendRequests(context)
                : ListView.separated(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + space16,
                    left: space16,
                    right: space16,
                    bottom: space16,
                  ),
                  itemCount: notifiController.friendRequests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: space12),
                  itemBuilder: (context, index) {
                    final request = notifiController.friendRequests[index];
                    final user = request.senderBy;

                    return Container(
                      padding: const EdgeInsets.all(space12),
                      decoration: BoxDecoration(
                        color: AppColor.cardLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              user?.avatar ??
                                  'https://api-private.atlassian.com/users/d9353865dad2be9cd7cced91c0a9d0ee/avatar',
                            ),
                          ),
                          const SizedBox(width: space12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? 'Người dùng',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'đã gửi lời mời kết bạn',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: space8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  notifiController.acceptFriendRequest(
                                    request.id!,
                                    'accepted',
                                  );
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: AppColor.success,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  notifiController.acceptFriendRequest(
                                    request.id!,
                                    'rejected',
                                  );
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: AppColor.error,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Widget _noFriendRequests(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.notifications_off_outlined,
                size: 64,
                color: AppColor.secondary,
              ),
              SizedBox(height: 16),
              Text(
                'Không có yêu cầu kết bạn nào',
                style: TextStyle(fontSize: 18, color: AppColor.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
