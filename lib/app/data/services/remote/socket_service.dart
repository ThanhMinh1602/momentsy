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
      _socket.emit("register", userId); // Đăng ký userId với BE
    });

    _socket.onReconnect((_) {
      print("🔄 WebSocket reconnected");
      _socket.emit("register", userId);
    });

    _socket.onDisconnect((_) {
      print("🔴 Disconnected from WebSocket");
      isConnected.value = false;
    });

    _socket.onConnectError((error) {
      print("❌ Lỗi kết nối WebSocket: $error");
      isConnected.value = false;
    });

    _listenForFriendRequests();
    _listenForFriendRequestAccepted();
  }

  void _listenForFriendRequests() {
    _socket.on("receiveFriendRequest", (data) {
      print("📩 Nhận lời mời kết bạn: $data");
      _onFriendRequestReceived?.call(data as Map<String, dynamic>);
    });
  }

  void _listenForFriendRequestAccepted() {
    _socket.on("friendRequestAccepted", (data) {
      print("✅ Lời mời kết bạn được chấp nhận: $data");
      _onFriendRequestAccepted?.call(data as Map<String, dynamic>);
    });
  }

  // Setters để lắng nghe sự kiện
  set onMessageReceived(Function(Map<String, dynamic>) callback) {
    _onMessageReceived = callback;
  }

  set onFriendRequestReceived(Function(Map<String, dynamic>) callback) {
    _onFriendRequestReceived = callback;
  }

  set onFriendRequestAccepted(Function(Map<String, dynamic>) callback) {
    _onFriendRequestAccepted = callback;
  }

  // Phát sự kiện tới backend (nếu cần cho các trường hợp khác)
  void emitEvent(String eventName, dynamic data) {
    if (_socket.connected) {
      _socket.emit(eventName, data);
    } else {
      print("⚠️ Không thể emit sự kiện `$eventName`, WebSocket chưa kết nối.");
    }
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  void dispose() {
    _socket.off("receiveFriendRequest");
    _socket.off("friendRequestAccepted");
    _socket.disconnect();
    _socket.dispose();
  }
}
