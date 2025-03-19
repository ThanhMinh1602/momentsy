import 'package:get/get.dart';
import 'package:momentsy/app/features/splash/viewmodels/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(() => SplashViewModel());
  }

}