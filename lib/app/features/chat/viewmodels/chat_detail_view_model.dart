import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/remote/chat_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class ChatDetailViewModel extends BaseViewModel {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final ScrollController scrollController = ScrollController();
  final SocketService _socketService;
  final ChatService _chatService;

  late UserModel userModel;

  ChatDetailViewModel({
    required SocketService socketService,
    required ChatService chatService,
  }) : _socketService = socketService,
       _chatService = chatService;

  @override
  void onInit() {
    super.onInit();
    userModel = Get.arguments;
    loadOldMessages();
    initSocket();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void loadOldMessages() async {
    final result = await _chatService.getConversation(
      userId,
      userModel.id ?? '',
    );
    result.fold(
      (l) {
        print('Get conversation fail: ${l.message}');
      },
      (r) {
        print(r);
        messages.assignAll(r.data ?? []);
      },
    );
  }

  void initSocket() {
    _socketService.on('newMessage', (data) {
      final message = MessageModel.fromJson(data);
      if (message.senderId == userModel.id) {
        messages.add(message);
        _scrollToBottom();
      }
    });
  }

  void sendMessage(String content) {
    final message = MessageModel(
      senderId: userId,
      receiverId: userModel.id,
      content: content,
      timestamp: DateTime.now(),
    );
    messages.add(message);
    _scrollToBottom();
    _socketService.emit('sendMessage', message.toJson());
  }
}
