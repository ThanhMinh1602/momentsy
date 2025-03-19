import 'package:get/get.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingViewModel());
  }
}
