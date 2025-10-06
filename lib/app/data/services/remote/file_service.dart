import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:momentsy/app/data/models/base/base_list_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exceptions/failure.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/app/data/models/base/base_model.dart';

abstract class IFileService {
  Future<Either<Failure, BaseModel>> fileUpload(File file);
  Future<Either<Failure, BaseListModel<ImageModel>>> getAllFile(String userId);
}

class FileService extends ApiService implements IFileService {
  @override
  Future<Either<Failure, BaseModel>> fileUpload(File file) async {
    try {
      // Gửi request POST
      final response = await uploadFile(
        ApiEndpoint.fileUpload,
        file,
        SharedPreferencesService.getUserId() ?? '',
      );
      print('File uploaded: $response');
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseListModel<ImageModel>>> getAllFile(
    String userId,
  ) async {
    try {
      final response = await get('${ApiEndpoint.allImage}/$userId');
      final Map<String, dynamic> jsonResponse = response.data;
      return Right(
        BaseListModel.fromJson(
          jsonResponse,
          itemFromJson: (json) => ImageModel.fromJson(json),
        ),
      );
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }
}
