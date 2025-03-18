import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:momentsy/core/config/api_endpoint.dart';
import 'package:momentsy/core/config/api_service.dart';
import 'package:momentsy/core/exception/failure.dart';
import 'package:momentsy/app/data/models/friend_request_model.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';

abstract class IFriendService {
  Future<Either<Failure, String>> sendFriendRequest(
      String senderId, String receiverId);

  Future<Either<Failure, String>> acceptFriendRequest(
      String requestId, String receiverId, String status);
  Future<Either<Failure, List<FriendRequestModel>>> getFriendRequests(
      String userId);
}

class FriendService extends ApiService implements IFriendService {
  final SocketService socketService;
  FriendService(this.socketService);

  @override
  Future<Either<Failure, String>> sendFriendRequest(
      String senderId, String receiverId) async {
    final data = {"senderId": senderId, "receiverId": receiverId};
    print(data);

    try {
      final response = await post(ApiEndpoint.sendFriendRequest, data: data);
      print("✅ Đã gửi lời mời qua API");
      return Right(
          response.data['message'] ?? "Gửi lời mời thành công qua API");
    } on DioException catch (e) {
      print("❌ Lỗi khi gửi lời mời: $e");

      // Lấy body từ response khi gặp lỗi
      final errorMessage = e.response?.data['message'] ?? "Lỗi không xác định";

      return Left(Failure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<FriendRequestModel>>> getFriendRequests(
      String userId) async {
    try {
      final response = await get('${ApiEndpoint.friendRequests}/$userId');

      if (response.statusCode != 200 || response.data['body'] == null) {
        return Left(Failure("❌ API trả về dữ liệu không hợp lệ"));
      }

      List<dynamic> listMap = response.data['body'];

      final requests =
          listMap.map((json) => FriendRequestModel.fromJson(json)).toList();
      return Right(requests);
    } catch (e) {
      if (e is DioError) {
        return Left(Failure("❌ API lỗi: ${e.response?.data ?? e.message}"));
      }
      return Left(Failure("❌ Lỗi không xác định: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> acceptFriendRequest(
      String requestId, String receiverId, String status) async {
    final data = {
      "requestId": requestId,
      "receiverId": receiverId,
      "status": status
    };
    print(data);

    try {
      final response = await post(ApiEndpoint.acceptFriendRequest, data: data);
      print("✅ Đã gửi lời mời qua API");
      return Right(
          response.data['message'] ?? "Gửi lời mời thành công qua API");
    } on DioException catch (e) {
      print("❌ Lỗi khi gửi lời mời: $e");

      // Lấy body từ response khi gặp lỗi
      final errorMessage = e.response?.data['message'] ?? "Lỗi không xác định";

      return Left(Failure(errorMessage));
    }
  }
}
