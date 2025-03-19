import 'package:get/get.dart';
import 'package:momentsy/app/features/home/viewmodels/home_view_model.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(fileService: Get.find()),
      fenix: true,
    );
  }
}
