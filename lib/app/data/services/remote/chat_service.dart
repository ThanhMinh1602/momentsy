import 'package:dio/dio.dart';
import 'package:momentsy/core/config/api_endpoint.dart';
import 'package:momentsy/core/config/api_service.dart';
import 'package:momentsy/app/data/body/chat_body.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';

abstract class IChatService {
  Future<void> sendMessage(ChatBody body);
}

class ChatService extends ApiService implements IChatService {
  final SocketService socketService;

  ChatService(this.socketService);

  @override
  Future<void> sendMessage(ChatBody body) async {
    try {
      if (socketService.isConnected.value) {
        socketService.emitEvent("sendMessage", body.toJson());
        print("📤 Tin nhắn đã gửi qua WebSocket: ${body.message}");
      } else {
        await post(ApiEndpoint.sendChat, data: body.toJson());
        print("📤 Tin nhắn đã gửi qua API REST: ${body.message}");
      }
    } on DioException catch (e) {
      throw handleDioException(e); // Ném lỗi để ChatController xử lý
    } catch (e) {
      throw Exception("Lỗi không mong muốn: $e");
    }
  }
}
