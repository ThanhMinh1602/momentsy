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
        backgroundColor: AppColor.k1A1C1E,
        body:
            notifiController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Obx(
                  () => ListView.separated(
                    padding: EdgeInsets.all(space12).copyWith(
                      top: MediaQuery.of(context).padding.top + space12,
                    ),
                    itemCount: notifiController.friendRequests.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: space12),
                    itemBuilder: (context, index) {
                      final request = notifiController.friendRequests[index];
                      return CustomAppCard(
                        backgroundColor: AppColor.black,
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
                              child: Text(
                                request.senderBy.name,
                                style: TextStyle(color: AppColor.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                notifiController.acceptFriendRequest(
                                  request.id,
                                  'accepted',
                                );
                              },
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: AppColor.primary,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                notifiController.acceptFriendRequest(
                                  request.id,
                                  'rejected',
                                );
                              },
                              icon: Icon(Icons.close, color: AppColor.red),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
      ),
    );
  }
}
