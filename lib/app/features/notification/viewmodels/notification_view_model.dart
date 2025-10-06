import 'package:get/get.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class NotificationViewModel extends BaseViewModel {
  NotificationViewModel({
    required SocketService socketService,
    required FriendService friendService,
  }) : _socketService = socketService,
       _friendService = friendService;

  final FriendService _friendService;
  final SocketService _socketService;
  RxList<FriendRequestModel> friendRequests = <FriendRequestModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFriendRequests();
   _socketService.onFriendRequestNotification().listen( (data) {
      final friendRequest = FriendRequestModel.fromJson(data);
      print('friendRequest: $friendRequest');
      friendRequests.add(friendRequest);
    });
  }

  Future<void> acceptFriendRequest(String requestId, String status) async {
    setLoading(true);
    final result = await _friendService.acceptFriendRequest(
      requestId,
      userId,
      status,
    );
    setLoading(false);

    result.fold(
      (l) {
        showError(l.message);
      },
      (r) async {
        showSuccess(r.message);
        await Future.delayed(const Duration(seconds: 2));
        friendRequests.removeWhere((request) => request.id == requestId);
      },
    );
  }

  Future<void> getFriendRequests() async {
    setLoading(true);
    final result = await _friendService.getFriendRequests(userId);
    setLoading(false);

    result.fold(
      (l) {
        showError(l.message);
      },
      (r) {
        friendRequests.assignAll(r.data ?? []); // Gán lại danh sách từ API
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
