import 'package:get/get.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class ChatViewModel extends BaseViewModel {
  final FriendService _friendService;
  final RxList<UserModel> userModels = <UserModel>[].obs;

  ChatViewModel({required FriendService friendService})
    : _friendService = friendService;
  @override
  void onInit() {
    super.onInit();
    _getFriendList();
  }

  Future<void> _getFriendList() async {
    if (userId == null) {
      Get.snackbar('Chưa đăng nhập', 'Vui lòng đăng nhập');
      return;
    }
    setLoading(true);
    final result = await _friendService.getFirendList(userId!);
    setLoading(false);
    result.fold(
      (l) {
        print('Get friend list fail: ${l.message}');
      },
      (r) {
        print(r);
        userModels.assignAll(r.data ?? []);
      },
    );
  }
}
