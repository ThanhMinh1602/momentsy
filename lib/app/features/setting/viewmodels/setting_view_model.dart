import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';

class SettingViewModel extends GetxController {
  final FriendService _friendService;
  final String? userId = SharedPreferencesService.getUserId();
  RxBool isLoading = false.obs;
  RxString qrResult = ''.obs;
  RxBool isProcessing = false.obs;
  SettingViewModel({required FriendService friendService})
    : _friendService = friendService;
  void logOut() async {
    await SharedPreferencesService.clear();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Future<void> sendFriendRequest(String receiverId) async {
    if (userId != null) {
      isLoading.value = true;
      final result = await _friendService.sendFriendRequest(
        userId!,
        receiverId,
      );
      isLoading.value = false;
      Get.back();
      result.fold(
        (l) {
          Get.snackbar('Lỗi', l.message);
        },
        (r) {
          Get.snackbar('Thành công', r);
        },
      );
    } else {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
    }
  }
}
