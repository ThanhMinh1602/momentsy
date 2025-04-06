import 'package:get/get.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_view_model.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatViewModel(friendService: Get.find()));
  }
}
