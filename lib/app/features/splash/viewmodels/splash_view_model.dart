import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
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
