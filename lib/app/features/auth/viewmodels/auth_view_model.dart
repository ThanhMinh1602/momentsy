import 'package:get/get.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/data/body/reset_password_body.dart';
import 'package:momentsy/app/data/body/verify_otp_body.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';

class AuthViewModel extends GetxController {
  final AuthService _authService;
  RxBool isLoading = false.obs;

  AuthViewModel({required AuthService authService})
    : _authService = authService;

  Future<void> register(RegisterBody registerBody) async {
    isLoading.value = true;
    final result = await _authService.register(registerBody);
    isLoading.value = false;

    result.fold((failure) => Get.snackbar("Lỗi", failure.message), (message) {
      Get.snackbar("Thành công", message);
      Get.offAndToNamed(AppRoutes.LOGIN, arguments: registerBody.email);
    });
  }

  Future<void> login(LoginBody loginBody) async {
    isLoading.value = true;
    final result = await _authService.login(loginBody);
    isLoading.value = false;

    result.fold((failure) => Get.snackbar("Lỗi", failure.message), (r) async {
      print('Data Response: ${r.token}, ${r.user?.id}');

      await SharedPreferencesService.setToken(r.token ?? '');
      await SharedPreferencesService.setUserId(r.user?.id ?? '');
      Get.offAndToNamed(AppRoutes.MAIN);
    });
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    final result = await _authService.sendOtp(email);
    isLoading.value = false;
    result.fold((failure) => Get.snackbar("Lỗi", failure.message), (message) {
      Get.snackbar("Thành công", message);
      Get.toNamed(AppRoutes.CONFIRMOTP, arguments: email);
    });
  }

  Future<void> verifyOtp(VerifyOtpBody body) async {
    isLoading.value = true;
    final result = await _authService.verifyOtp(body);
    isLoading.value = false;
    result.fold(
      (l) {
        Get.snackbar("Lỗi", l.message);
      },
      (r) {
        Get.snackbar("Thành công", r.message);
        Get.toNamed(AppRoutes.RESETPASSWORD, arguments: r.resetToken);
      },
    );
  }

  Future<void> resetPassword(ResetPasswordBody body) async {
    isLoading.value = true;
    final result = await _authService.resetPassword(body);
    isLoading.value = false;
    result.fold((failure) => Get.snackbar("Lỗi", failure.message), (message) {
      Get.snackbar("Thành công", message);
      Get.offAndToNamed(AppRoutes.LOGIN);
    });
  }
}
