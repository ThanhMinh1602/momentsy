import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/core/config/api_endpoint.dart';
import 'package:momentsy/core/config/api_service.dart';
import 'package:momentsy/core/exception/failure.dart';
import 'package:momentsy/app/data/models/image_model.dart';

abstract class IFileService {
  Future<Either<Failure, String>> fileUpload(File file);
  Future<Either<Failure, List<ImageModel>>> getAllFile(String userId);
}

class FileService extends ApiService implements IFileService {
  @override
  Future<Either<Failure, String>> fileUpload(File file) async {
    try {
      // Gửi request POST
      final response = await uploadFile(
        ApiEndpoint.fileUpload,
        file,
        SharedPreferencesService.getUserIds,
      );
      print('File uploaded: $response');

      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getAllFile(String userId) async {
    try {
      final response = await get('${ApiEndpoint.allImage}/$userId');
      final List<dynamic> images = response.data['images'];
      return Right(images.map((e) => ImageModel.fromJson(e)).toList());
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }
}
