import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class MainViewModel extends BaseViewModel {
  final socketService = Get.find<SocketService>();
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    socketService.initSocket(userId);
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}
