import 'package:get/get.dart';
import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class ChatDetailViewModel extends BaseViewModel {
  final RxList<MessageModel> messages = <MessageModel>[].obs;

  @override
  void onInit() {
    initSocket();
    super.onInit();
  }

  void initSocket() {}

  void sendMessage(String receiverId, String content) {
    // socketService.sendMessage(receiverId, content);
    messages.add(
      MessageModel(
        senderId: userId!,
        receiverId: receiverId,
        content: content,
        timestamp: DateTime.now(),
      ),
    );
  }
}
