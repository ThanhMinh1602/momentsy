import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  late IO.Socket _socket;
  final String userId;
  Function(Map<String, dynamic>)? _onMessageReceived;
  Function(Map<String, dynamic>)? _onFriendRequestReceived;
  Function(Map<String, dynamic>)? _onFriendRequestAccepted;
  RxBool isConnected = false.obs;

  SocketService({required this.userId}) {
    _connectSocket();
  }

  void _connectSocket() {
    _socket = IO.io(
      dotenv.env['WS_API'],
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print("🟢 Connected to WebSocket");
      isConnected.value = true;
      _socket.emit("register", userId); // Đăng ký userId với backend
    });

    // Nhận lời mời kết bạn từ backend
    receiveFriendRequest();

    // Nhận thông báo khi lời mời được chấp nhận
    _socket.on("friendRequestAccepted", (data) {
      print("✅ Lời mời kết bạn được chấp nhận: $data");
      if (_onFriendRequestAccepted != null) {
        _onFriendRequestAccepted!(data);
      }
    });

    _socket.onDisconnect((_) {
      print("🔴 Disconnected from WebSocket");
      isConnected.value = false;
    });

    _socket.onConnectError((error) {
      print("❌ Lỗi kết nối WebSocket: $error");
      isConnected.value = false;
    });
  }

  Function receiveFriendRequest() {
    return _socket.on("receiveFriendRequest", (data) {
      print("📩 Nhận lời mời kết bạn: $data");
      if (_onFriendRequestReceived != null) {
        _onFriendRequestReceived!(data);
      }
    });
  }

  set onMessageReceived(Function(Map<String, dynamic>) callback) {
    _onMessageReceived = callback;
  }

  // Callback khi nhận lời mời kết bạn
  set onFriendRequestReceived(Function(Map<String, dynamic>) callback) {
    _onFriendRequestReceived = callback;
  }

  // Callback khi lời mời được chấp nhận
  set onFriendRequestAccepted(Function(Map<String, dynamic>) callback) {
    _onFriendRequestAccepted = callback;
  }

  // Phát sự kiện tới backend
  void emitEvent(String eventName, dynamic data) {
    if (_socket.connected) {
      _socket.emit(eventName, data);
    } else {
      print("⚠️ Không thể emit sự kiện `$eventName`, WebSocket chưa kết nối.");
    }
  }

  // Gửi lời mời kết bạn qua Socket
  void sendFriendRequest(String receiverId) {
    emitEvent("sendFriendRequest", {
      "senderId": userId,
      "receiverId": receiverId,
    });
  }

  void dispose() {
    _socket.disconnect();
    _socket.dispose();
  }
}
