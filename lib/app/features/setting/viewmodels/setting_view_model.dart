import 'dart:io';

import 'package:get/get.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/user_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/utils/pick_file_utils.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class SettingViewModel extends BaseViewModel {
  final FriendService _friendService;
  final UserService _userService;
  final AuthService _authService;
  RxString qrResult = ''.obs;
  Rx<File?> avatarFile = Rx<File?>(null);
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
    getUserById(userId);
  }

  Future<void> avaterPicker() async {
    final file = await PickFileUtils.pickImageFile();
    if (file != null) {
      print('Tesst_file: ${file.runtimeType}');
      avatarFile.value = file;
    }
  }

  // Lấy thông tin người dùng theo ID
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

  // Cập nhật thông tin người dùng và avatar
  void updateUserProfile(String name, String email, File? file) async {
    setLoading(true);

    // Gọi service để cập nhật avatar nếu có file
    final result = await _userService.updateUser(
      user.value.copyWith(name: name, email: email),
      file: file,
    );
    setLoading(false);

    result.fold(
      (l) {
        showError(l.message);
      },
      (r) {
        showSuccess(r.message);
        user.value = r.data!; // Cập nhật thông tin người dùng mới
      },
    );
  }

  // // Cập nhật avatar
  // void updateAvatar(File file) async {
  //   setLoading(true);
  //   final result = await _userService.updateUser(user.value, file: file);
  //   setLoading(false);

  //   result.fold(
  //     (l) {
  //       showError(l.message);
  //     },
  //     (r) {
  //       showSuccess(r.message);
  //       user.value = r.data!; // Cập nhật avatar mới
  //     },
  //   );
  // }

  // Đăng xuất người dùng
  void logOut() async {
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

  // Gửi lời mời kết bạn
  Future<void> sendFriendRequest(String receiverId) async {
    setLoading(true);
    final result = await _friendService.sendFriendRequest(userId!, receiverId);
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
  }
}
