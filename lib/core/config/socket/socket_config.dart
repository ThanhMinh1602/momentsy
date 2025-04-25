import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConfig {
  late IO.Socket _socket;
  final Map<String, StreamController<dynamic>> _streamControllers = {};

  static final SocketConfig _instance = SocketConfig._internal();

  factory SocketConfig() => _instance;

  SocketConfig._internal();

  bool get isConnected => _socket.connected;

  void initSocket(String userId) {
    _socket = IO.io(dotenv.env['SOCKET_URL'], IO.OptionBuilder()
      .setTransports(['websocket']) // Chỉ sử dụng WebSocket
      .enableReconnection()         // Bật tính năng tự động kết nối lại
      .setReconnectionAttempts(10)   // Số lần thử lại kết nối
      .setReconnectionDelay(1000)   // Thời gian chờ giữa các lần thử lại (ms)
      .setReconnectionDelayMax(5000) // Thời gian tối đa giữa các lần thử lại (ms)
      .setQuery({'userId': userId}) // Tham số query cho kết nối
      .disableAutoConnect()        // Tắt tự động kết nối khi khởi tạo
      .build());
  


    _socket.connect();
    _socket.onConnect((_) => print('✅ Socket connected'));
    _socket.onDisconnect((_) => print('❌ Socket disconnected'));
    _socket.onError((data) => print('🚨 Socket error: $data'));
  }

  /// Gửi sự kiện từ client lên server
  void emit(String eventName, dynamic data) {
    _socket.emit(eventName, data);
  }

  /// Lắng nghe sự kiện bằng Stream
  Stream<dynamic> listenStream(String eventName) {
    if (!_streamControllers.containsKey(eventName)) {
      final controller = StreamController<dynamic>.broadcast();
      _streamControllers[eventName] = controller;

      _socket.on(eventName, (data) {
        controller.add(data);
      });
    }
    return _streamControllers[eventName]!.stream;
  }

  /// Ngắt kết nối socket và đóng tất cả stream
  void dispose() {
    _socket.disconnect();
    for (var controller in _streamControllers.values) {
      controller.close();
    }
    _streamControllers.clear();
  }
}
