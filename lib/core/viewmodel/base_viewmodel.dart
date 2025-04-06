import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';

abstract class BaseViewModel extends GetxController {
  var isLoading = false.obs;
  final String? userId = SharedPreferencesService.getUserId();

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
