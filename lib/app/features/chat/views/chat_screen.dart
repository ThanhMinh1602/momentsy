import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';
import 'package:momentsy/app/features/chat/views/widgets/chat_view.dart';
import 'package:momentsy/app/features/chat/views/widgets/friend_list.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/tabbar/custom_tab_bar.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late TabController tabController;
  final _controller = Get.find<ChatViewModel>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12.0,
            ),
            child: CustomTabBar(
              tabController: tabController,
              tabsTitle: ['Tin nhắn', 'Bạn bè'],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [ChatList(), FriendList(chatViewModel: _controller)],
            ),
          ),
        ],
      ),
    );
  }
}
