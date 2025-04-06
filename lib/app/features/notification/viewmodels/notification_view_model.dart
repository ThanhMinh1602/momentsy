import 'package:get/get.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class NotificationViewModel extends BaseViewModel {
  NotificationViewModel({required FriendService friendService})
    : _friendService = friendService;

  final FriendService _friendService;
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

    setLoading(true);
    final result = await _friendService.acceptFriendRequest(
      requestId,
      userId!,
      status,
    );
    setLoading(false);

    result.fold(
      (l) {
        showError(l.message);
      },
      (r) async {
        showSuccess(r.message);
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

    setLoading(true);
    final result = await _friendService.getFriendRequests(userId!);
    setLoading(false);

    result.fold(
      (l) {
        showError(l.message);
      },
      (r) {
        friendRequests.assignAll(r.data ?? []); // Gán lại danh sách từ API
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
