import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:momentsy/app/data/models/base/base_list_model.dart';
import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/app/data/body/chat_body.dart';
import 'package:momentsy/core/exceptions/failure.dart';

abstract class IChatService {
  Future<Either<Failure, BaseListModel<MessageModel>>> getConversation(
    String userId,
    String receiverId,
  );
}

class ChatService extends ApiService implements IChatService {
  ChatService();

  @override
  Future<Either<Failure, BaseListModel<MessageModel>>> getConversation(
    String userId,
    String receiverId,
  ) async {
    try {
      final response = await get(
        '${ApiEndpoint.getConversation}/$userId/$receiverId',
      );
      print("✅ Đã gửi lời mời qua API: ${response.data}");
      return Right(
        BaseListModel<MessageModel>.fromJson(
          response.data,
          itemFromJson: (data) => MessageModel.fromJson(data),
        ),
      );
    } on DioException catch (e) {
      print("❌ Lỗi khi gửi lời mời: $e");
      final errorMessage = e.response?.data['message'] ?? "Lỗi không xác định";
      return Left(Failure(errorMessage));
    }
  }
}
