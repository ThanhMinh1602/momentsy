
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';

class SplashViewModel extends GetxController{
  @override
  void onInit() {
    Future.delayed(
      Duration(seconds: 2),
      () => Get.offAllNamed(
        SharedPreferencesService.getToken() != null
            ? AppRoutes.MAIN
            : AppRoutes.LOGIN,
      ),
    );
    super.onInit();
  }
}