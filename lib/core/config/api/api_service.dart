import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:momentsy/core/exception/dio_exception.dart';

abstract class ApiService with DioExceptionMixin {
  late Dio _dio;
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_API'] ?? "http://localhost:5000",
        connectTimeout: Duration(seconds: 40),
        receiveTimeout: Duration(seconds: 40),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    // Thêm interceptor để log request & response (debug)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('➡️ Request: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response [${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('❌ Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // Phương thức GET
  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      return await _dio.get(endpoint, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức POST
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức PUT
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức DELETE
  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      rethrow;
    }
  }

  // Thêm phương thức upload file
  Future<Response> uploadFile(String endpoint, File file, String userId) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
        "userId": userId,
      });

      return await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
    } catch (e) {
      rethrow;
    }
  }
}
