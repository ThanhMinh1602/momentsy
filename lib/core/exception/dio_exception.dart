import 'package:dio/dio.dart';
import 'package:momentsy/core/exception/failure.dart';

mixin DioExceptionMixin {
  Failure handleDioException(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return Failure(
            "Yêu cầu không hợp lệ: ${e.response?.data['message']}",
          );
        case 401:
          return Failure(
            "Không có quyền truy cập: ${e.response?.data['message']}",
          );
        case 403:
          return Failure(
            "Bị từ chối quyền truy cập: ${e.response?.data['message']}",
          );
        case 404:
          return Failure(
            "Không tìm thấy tài nguyên: ${e.response?.data['message']}",
          );
        case 500:
          return Failure("Lỗi server: ${e.response?.data['message']}");
        default:
          return Failure(
            e.response?.data['message'] ?? "Lỗi không xác định từ server",
          );
      }
    }
    return Failure("Lỗi kết nối: ${e.message}");
  }
}
