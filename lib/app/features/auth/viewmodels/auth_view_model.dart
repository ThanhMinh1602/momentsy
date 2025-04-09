import 'package:get/get.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/data/body/reset_password_body.dart';
import 'package:momentsy/app/data/body/verify_otp_body.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/auth_service.dart';
import 'package:momentsy/core/config/firebase/notification_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService;

  AuthViewModel({required AuthService authService})
    : _authService = authService;

  Future<void> register(RegisterBody registerBody) async {
    setLoading(true);
    final result = await _authService.register(registerBody);
    setLoading(false);

    result.fold((failure) => showError(failure.message), (r) {
      showSuccess(r.message);
      Get.offAndToNamed(AppRoutes.LOGIN, arguments: registerBody.email);
    });
  }

  Future<void> login(LoginBody loginBody) async {
    setLoading(true);
    final deviceToken = await NotificationService().getDeviceToken();
    loginBody.deviceToken = deviceToken;
    final result = await _authService.login(loginBody);
    setLoading(false);

    result.fold((failure) => showError(failure.message), (r) async {
      print('Data Response: ${r.data?.token}, ${r.data?.user?.id}');

      await SharedPreferencesService.setToken(r.data?.token ?? '');
      await SharedPreferencesService.setUserId(r.data?.user?.id ?? '');
      Get.offAndToNamed(AppRoutes.MAIN);
    });
  }

  Future<void> forgotPassword(String email) async {
    setLoading(true);
    final result = await _authService.sendOtp(email);
    setLoading(false);
    result.fold((l) => showError(l.message), (r) {
      showSuccess(r.message);
      Get.toNamed(AppRoutes.CONFIRMOTP, arguments: email);
    });
  }

  Future<void> verifyOtp(VerifyOtpBody body) async {
    setLoading(true);
    final result = await _authService.verifyOtp(body);
    setLoading(false);
    result.fold(
      (l) {
        showError(l.message);
      },
      (r) {
        showSuccess(r.message);
        print('Reset Token: ${r.data?.resetToken}');
        Get.toNamed(AppRoutes.RESETPASSWORD, arguments: r.data?.resetToken);
      },
    );
  }

  Future<void> resetPassword(ResetPasswordBody body) async {
    setLoading(true);
    final result = await _authService.resetPassword(body);
    setLoading(false);
    result.fold((failure) => showError(failure.message), (r) {
      showSuccess(r.message);
      Get.offAndToNamed(AppRoutes.LOGIN);
    });
  }
}
