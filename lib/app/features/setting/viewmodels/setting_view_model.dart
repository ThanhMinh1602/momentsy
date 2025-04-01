import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class SettingViewModel extends BaseViewModel {
  final FriendService _friendService;
  final String? userId = SharedPreferencesService.getUserId();
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
      setLoading(true);
      final result = await _friendService.sendFriendRequest(
        userId!,
        receiverId,
      );
      setLoading(false);
      Get.back();
      result.fold(
        (l) {
          showError(l.message);
        },
        (r) {
          showSuccess(r);
        },
      );
    } else {
      showError('Vui lòng đăng nhập');
    }
  }
}
