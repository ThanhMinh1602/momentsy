import 'package:get/get.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/user_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class SettingViewModel extends BaseViewModel {
  final FriendService _friendService;
  final UserService _userService;
  final AuthService _authService;
  RxString qrResult = ''.obs;
  RxBool isProcessing = false.obs;
  Rx<UserModel> user = UserModel().obs;
  SettingViewModel({
    required FriendService friendService,
    required UserService userService,
    required AuthService authService,
  }) : _friendService = friendService,
       _userService = userService,
       _authService = authService;
  @override
  void onInit() {
    super.onInit();
    getUserById(userId!);
  }

  void getUserById(String userId) async {
    final result = await _userService.getUserById(userId);
    result.fold(
      (l) {
        print(l.message);
      },
      (r) {
        user.value = r.data!;
      },
    );
  }

  void logOut() async {
    if (userId == null) {
      Get.snackbar('Lỗi', 'Vui lòng đăng nhập');
      return;
    }
    setLoading(true);
    await SharedPreferencesService.clear();
    final result = await _authService.logout(userId!);
    setLoading(false);
    result.fold(
      (l) {
        showError(l.message);
      },
      (r) {
        Get.offAllNamed(AppRoutes.LOGIN);
      },
    );
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
          showSuccess(r.message);
        },
      );
    } else {
      showError('Vui lòng đăng nhập');
    }
  }
}
