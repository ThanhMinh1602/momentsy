import 'package:get/get.dart';
import 'package:momentsy/app/features/chat/viewmodels/chat_detail_view_model.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailViewModel());
  }
}
