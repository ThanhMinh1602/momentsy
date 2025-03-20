import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/chat_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/app/features/main/viewmodels/main_view_model.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainViewModel());
  }
}
