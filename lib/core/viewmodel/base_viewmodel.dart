import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';

abstract class BaseViewModel extends GetxController {
  final socketHelper = Get.find<SocketService>();
  var isLoading = false.obs;
  final String? _userId = SharedPreferencesService.getUserId();

  String get userId {
    if (_userId != null) {
      return _userId;
    } else {
      showError('Chưa đăng nhập');
      return '';
    }
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void showError(String? message) {
    Get.snackbar('Lỗi', message ?? '');
  }

  void showSuccess(String message) {
    Get.snackbar('Thành công', message);
  }
}
