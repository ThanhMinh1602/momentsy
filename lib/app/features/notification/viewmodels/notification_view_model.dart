import 'package:get/get.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';

class NotificationViewModel extends GetxController {
  NotificationViewModel({required FriendService friendService})
    : _friendService = friendService;
  final FriendService _friendService;
  final String? userId = SharedPreferencesService.getUserId();
  RxList<FriendRequestModel> friendRequests = <FriendRequestModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getFriendRequests();
  }

  Future<void> acceptFriendRequest(String requestId, String status) async {
    if (userId != null) {
      isLoading.value = true;
      final result = await _friendService.acceptFriendRequest(
        requestId,
        userId!,
        status,
      );
      isLoading.value = false;
      result.fold(
        (l) {
          Get.snackbar('Lỗi', l.message);
        },
        (r) async {
          Get.snackbar('Thành công', r);
          await Future.delayed(Duration(seconds: 2));
          _getFriendRequests();
        },
      );
    } else {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
    }
  }

  Future<void> _getFriendRequests() async {
    if (userId != null) {
      isLoading.value = true;
      final result = await _friendService.getFriendRequests(userId!);
      isLoading.value = false;
      Get.back();
      result.fold(
        (l) {
          print('Lổi: $l');
        },
        (r) {
          friendRequests.value = r;
        },
      );
    } else {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
    }
  }
}
