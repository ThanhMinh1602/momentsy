import 'dart:async';

import 'package:momentsy/core/config/socket/socket_config.dart';

class SocketService {
  final SocketConfig _socket ;

  SocketService(this._socket);

  void init(String userId) {
    _socket.initSocket(userId);
  }

  void dispose() {
    _socket.dispose();
  }
}


extension EmitEvent on SocketService{

  /// Gửi tin nhắn
  void sendMessage(Map<String, dynamic> messageData) {
    print('sendMessage on socket: $messageData');
    _socket.emit('send_message', messageData);
  }

  /// Gửi yêu cầu thông báo (ví dụ admin push noti)
  void sendNotificationRequest(Map<String, dynamic> data) {
    _socket.emit('send_notification', data);
  }

}

extension ListenEvent on SocketService{

  /// Lắng nghe tin nhắn đến
  Stream<dynamic> onMessageReceived() {
    return _socket.listenStream('new_message');
  }

  /// Lắng nghe khi có thông báo
  Stream<dynamic> onFriendRequestNotification() {
    return _socket.listenStream('friend_request');
  }
}