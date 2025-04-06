import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:momentsy/app/data/models/base/base_list_model.dart';
import 'package:momentsy/app/data/models/base/base_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exceptions/failure.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';

abstract class IFriendService {
  Future<Either<Failure, BaseModel>> sendFriendRequest(
    String senderId,
    String receiverId,
  );

  Future<Either<Failure, BaseModel>> acceptFriendRequest(
    String requestId,
    String receiverId,
    String status,
  );

  Future<Either<Failure, BaseListModel<FriendRequestModel>>> getFriendRequests(
    String userId,
  );
  Future<Either<Failure, BaseListModel<UserModel>>> getFirendList(
    String userId,
  );
}

class FriendService extends ApiService implements IFriendService {
  @override
  Future<Either<Failure, BaseModel>> sendFriendRequest(
    String senderId,
    String receiverId,
  ) async {
    final data = {"senderId": senderId, "receiverId": receiverId};
    print("📤 Gửi lời mời: $data");

    try {
      final response = await post(ApiEndpoint.sendFriendRequest, data: data);
      print("✅ Đã gửi lời mời qua API: ${response.data}");
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      print("❌ Lỗi khi gửi lời mời: $e");
      final errorMessage = e.response?.data['message'] ?? "Lỗi không xác định";
      return Left(Failure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, BaseModel>> acceptFriendRequest(
    String requestId,
    String receiverId,
    String status,
  ) async {
    final data = {
      "requestId": requestId,
      "receiverId": receiverId,
      "status": status,
    };
    print("📤 Xử lý lời mời: $data");

    try {
      final response = await post(ApiEndpoint.acceptFriendRequest, data: data);
      print("✅ Đã xử lý lời mời qua API: ${response.data}");
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      print("❌ Lỗi khi xử lý lời mời: $e");
      final errorMessage = e.response?.data['message'] ?? "Lỗi không xác định";
      return Left(Failure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, BaseListModel<FriendRequestModel>>> getFriendRequests(
    String userId,
  ) async {
    try {
      final response = await get('${ApiEndpoint.friendRequests}/$userId');
      return Right(
        BaseListModel.fromJson(
          response.data,
          itemFromJson: (json) => FriendRequestModel.fromJson(json),
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(Failure("❌ API lỗi: ${e.response?.data ?? e.message}"));
      }
      return Left(Failure("❌ Lỗi không xác định: $e"));
    }
  }

  @override
  Future<Either<Failure, BaseListModel<UserModel>>> getFirendList(
    String userId,
  ) async {
    try {
      final response = await get('${ApiEndpoint.friendList}/$userId');
      return Right(
        BaseListModel.fromJson(
          response.data,
          itemFromJson: (json) => UserModel.fromJson(json),
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(Failure("❌ API lỗi: ${e.response?.data ?? e.message}"));
      }
      return Left(Failure("❌ Lỗi không xác định: $e"));
    }
  }
}
