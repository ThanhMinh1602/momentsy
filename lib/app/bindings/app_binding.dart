import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(FileService());
    Get.put(FriendService());
  }
}
