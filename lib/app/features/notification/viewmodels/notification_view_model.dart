import 'package:get/get.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/core/config/firebase/notification_service.dart';

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
    if (userId == null) {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
      return;
    }

    isLoading.value = true;
    final result = await _friendService.acceptFriendRequest(
      requestId,
      userId!,
      status,
    );
    isLoading.value = false;

    result.fold(
      (failure) {
        Get.snackbar('Lỗi', failure.message);
      },
      (message) async {
        Get.snackbar('Thành công', message);
        await Future.delayed(const Duration(seconds: 2));
        _getFriendRequests(); // Cập nhật lại danh sách sau khi xử lý
      },
    );
  }

  Future<void> _getFriendRequests() async {
    if (userId == null) {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
      return;
    }

    isLoading.value = true;
    final result = await _friendService.getFriendRequests(userId!);
    isLoading.value = false;

    result.fold(
      (failure) {
        print('Lỗi: ${failure.message}');
      },
      (requests) {
        friendRequests.assignAll(requests); // Gán lại danh sách từ API
      },
    );
  }
}
