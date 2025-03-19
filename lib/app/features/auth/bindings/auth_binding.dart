import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(authService: Get.find()));
  }
}
