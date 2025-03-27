import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/notification/viewmodels/notification_view_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/card/custom_app_card.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final notifiController = Get.find<NotificationViewModel>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        notifiController.onInit();
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(title: Text('Thông báo'), elevation: 0),
        body:
            notifiController.isLoading.value
                ? Center(
                  child: CircularProgressIndicator(color: AppColor.primary),
                )
                : Obx(
                  () =>
                      notifiController.friendRequests.isEmpty
                          ? Center(
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
                                    Icons.notifications_none,
                                    size: 64,
                                    color: AppColor.primary,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Không có thông báo mới',
                                  style: TextStyle(
                                    color: AppColor.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.separated(
                            padding: EdgeInsets.all(
                              space12,
                            ).copyWith(top: space12),
                            itemCount: notifiController.friendRequests.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: space12),
                            itemBuilder: (context, index) {
                              final request =
                                  notifiController.friendRequests[index];
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          request.senderBy.avatar ??
                                              'https://api-private.atlassian.com/users/d9353865dad2be9cd7cced91c0a9d0ee/avatar',
                                        ),
                                      ),
                                      SizedBox(width: space12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              request.senderBy.name,
                                              style: TextStyle(
                                                color: AppColor.textPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Gửi lời mời kết bạn',
                                              style: TextStyle(
                                                color: AppColor.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              notifiController
                                                  .acceptFriendRequest(
                                                    request.id,
                                                    'accepted',
                                                  );
                                            },
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: AppColor.success,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              notifiController
                                                  .acceptFriendRequest(
                                                    request.id,
                                                    'rejected',
                                                  );
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: AppColor.error,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
      ),
    );
  }
}
