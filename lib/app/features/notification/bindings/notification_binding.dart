import 'package:get/get.dart';
import 'package:momentsy/app/features/notification/viewmodels/notification_view_model.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationViewModel(friendService: Get.find()));
  }
}
