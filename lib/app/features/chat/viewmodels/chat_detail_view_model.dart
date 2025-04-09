import 'package:get/get.dart';
import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/app/data/services/remote/chat_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class ChatDetailViewModel extends BaseViewModel {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final SocketService _socketService;
  final ChatService _chatService;

  late String receiverId;

  ChatDetailViewModel({
    required SocketService socketService,
    required ChatService chatService,
  }) : _socketService = socketService,
       _chatService = chatService;

  @override
  void onInit() {
    super.onInit();
    receiverId = Get.arguments;
    loadOldMessages();
    initSocket();
  }

  void loadOldMessages() async {
    final result = await _chatService.getConversation(userId, receiverId);
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
      if (message.senderId == receiverId || message.receiverId == receiverId) {
        messages.add(message);
      }
    });
  }

  void sendMessage(String content) {
    final message = MessageModel(
      senderId: userId,
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
    );

    messages.add(message);

    _socketService.emit('sendMessage', message.toJson());
  }
}
