import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';

class SettingViewModel extends GetxController {
  void logOut() async {
    await SharedPreferencesService.clear();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
