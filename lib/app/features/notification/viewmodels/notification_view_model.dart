import 'package:get/get.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/services/local/notification_service.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';

class NotificationViewModel extends GetxController {
  NotificationViewModel({
    required FriendService friendService,
    required SocketService socketService,
  }) : _friendService = friendService,
       _socketService = socketService;

  final FriendService _friendService;
  final SocketService _socketService; // Đảm bảo socketService được khởi tạo
  final String? userId = SharedPreferencesService.getUserId();
  RxList<FriendRequestModel> friendRequests = <FriendRequestModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit(); // Khởi tạo SocketService với userId
    _getFriendRequests(); // Lấy danh sách ban đầu từ API
    _setupSocketListeners(); // Thiết lập lắng nghe socket
  }

  Future<void> acceptFriendRequest(String requestId, String status) async {
    if (userId == null) {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
      return;
    }

    isLoading.value = true;
    final result = await _friendService.acceptFriendRequest(
      requestId,
      userId!,
      status,
    );
    isLoading.value = false;

    result.fold(
      (failure) {
        Get.snackbar('Lỗi', failure.message);
      },
      (message) async {
        Get.snackbar('Thành công', message);
        await Future.delayed(const Duration(seconds: 2));
        _getFriendRequests(); // Cập nhật lại danh sách sau khi xử lý
      },
    );
  }

  Future<void> _getFriendRequests() async {
    if (userId == null) {
      Get.snackbar('Cảnh báo', 'Vui lòng đăng nhập');
      return;
    }

    isLoading.value = true;
    final result = await _friendService.getFriendRequests(userId!);
    isLoading.value = false;

    result.fold(
      (failure) {
        print('Lỗi: ${failure.message}');
      },
      (requests) {
        friendRequests.assignAll(requests); // Gán lại danh sách từ API
      },
    );
  }

  void _setupSocketListeners() {
    // Lắng nghe khi có lời mời kết bạn mới
    _socketService.onFriendRequestReceived = (data) async {
      print("📩 Nhận lời mời qua socket: $data");
      final friendRequest = FriendRequestModel.fromJson(data);

      if (!friendRequests.any((req) => req.id == friendRequest.id)) {
        await NotificationService.showNotification(
          id: friendRequest.id.hashCode,
          title: 'Lời mời kết bạn!',
          body: '${friendRequest.senderBy.name} đã gửi lời mời kết bạn.',
        );
        friendRequests.add(friendRequest);
      }
    };

    // Lắng nghe khi lời mời được chấp nhận
    _socketService.onFriendRequestAccepted = (data) async {
      print("✅ Lời mời được chấp nhận qua socket: $data");
      final requestId = data['requestId']?.toString();
      final message = data['message']?.toString();
      if (requestId != null) {
        await NotificationService.showNotification(
          id: requestId.hashCode,
          title: 'Thông báo kết bạn',
          body: message ?? 'Yêu cầu kết bạn đã được chấp nhận.',
        );
        friendRequests.removeWhere((req) => req.id == requestId);
      } else {
        _getFriendRequests(); // Cập nhật lại danh sách nếu dữ liệu không chính xác
      }
    };
  }

  @override
  void onClose() {
    _socketService.dispose(); // Đảm bảo giải phóng socket khi đóng
    super.onClose();
  }
}
