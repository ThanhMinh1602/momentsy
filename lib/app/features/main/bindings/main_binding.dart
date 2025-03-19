import 'package:get/get.dart';
import 'package:momentsy/app/features/main/viewmodels/main_view_model.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainViewModel());
  }
}
