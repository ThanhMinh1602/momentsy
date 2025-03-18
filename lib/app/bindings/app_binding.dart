import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';
import 'package:momentsy/app/data/services/remote/chat_service.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    String? userId = SharedPreferencesService.getUserId();
    Get.put(AuthService());
    Get.put(FileService());
    if (userId != null) {
      // Khởi tạo SocketService với userId và giữ nó permanent
      Get.put(SocketService(userId: userId), permanent: true);
      Get.put(ChatService(Get.find<SocketService>()));
      Get.put(FriendService(Get.find<SocketService>()));
    } else {
      print(
        "⚠️ Không thể khởi tạo SocketService, userId null. Vui lòng đăng nhập.",
      );
    }
  }
}
