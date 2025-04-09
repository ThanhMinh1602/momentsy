import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(String userId) {
    socket = IO.io(dotenv.env['SOCKET_URL'], <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': userId},
    });

    socket.connect();
  }

  void on(String eventName, Function(dynamic data) handler) {
    socket.on(eventName, handler);
  }

  void emit(String eventName, dynamic data) {
    socket.emit(eventName, data);
  }

  void dispose() {
    socket.disconnect();
  }
}
