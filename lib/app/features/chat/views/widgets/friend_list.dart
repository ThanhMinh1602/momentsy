import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key, required this.chatViewModel});
  final ChatViewModel chatViewModel;
  @override
  Widget build(BuildContext context) {
    final friends = chatViewModel.userModels;
    return Obx(
      () => ListView.separated(
        itemCount: friends.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (_, __) => SizedBox(height: space6),

        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2024/12/26/17/31/newborn-photography-9292505_1280.jpg',
              ),
            ),
            title: Text(
              friends[index].name ?? '--:--',
              style: AppStyle.semiBold12,
            ),
          );
        },
      ),
    );
  }
}
