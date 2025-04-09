import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class MainViewModel extends BaseViewModel {
  final socketService = Get.find<SocketService>();

  @override
  void onInit() {
    super.onInit();
    socketService.initSocket(userId);
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}
