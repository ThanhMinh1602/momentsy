import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  var isLoading = false.obs;

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
