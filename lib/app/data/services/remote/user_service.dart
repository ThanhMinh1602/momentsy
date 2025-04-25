import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:momentsy/app/data/models/base/base_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exceptions/failure.dart';

abstract class IUserService {
  Future<Either<Failure, BaseModel<UserModel>>> getUserById(String userId);
  Future<Either<Failure, BaseModel<UserModel>>> updateUser(UserModel user, {File? file});

}

class UserService extends ApiService implements IUserService {
  @override
  Future<Either<Failure, BaseModel<UserModel>>> getUserById(
    String userId,
  ) async {
    try {
      final response = await get('${ApiEndpoint.getUserById}/$userId');
      final user = BaseModel<UserModel>.fromJson(
        response.data,
        dataFromJson: (json) => UserModel.fromJson(json),
      );
      return Right(user);
    } catch (e) {
      return Left(Failure('Lỗi không mong muốn: $e'));
    }
  }
  @override
Future<Either<Failure, BaseModel<UserModel>>> updateUser(UserModel user, {File? file}) async {
  try {
    String avatar = user.avatar ?? ''; // Giữ nguyên avatar cũ nếu không upload ảnh mới.

    // Nếu có file (avatar mới), thực hiện upload
    if (file != null) {
      final fileUploadResponse = await uploadFile(
        ApiEndpoint.fileUpload, 
        file, 
        user.id!,
        fileType: 'avatar',
      );

      if (fileUploadResponse.data != null) {
        avatar = fileUploadResponse.data; // Cập nhật avatar mới
        print('Avatar uploaded successfully: $avatar');
      } else {
        return Left(Failure('Lỗi khi upload avatar'));
      }
    }

    // Cập nhật thông tin người dùng
    user = user.copyWith(avatar: avatar);
    final response = await put(
      ApiEndpoint.updateUserProfile,
      data: user.toJson(),
    );

    // Phân tích dữ liệu phản hồi từ API
    final updatedUser = BaseModel<UserModel>.fromJson(
      response.data,
      dataFromJson: (json) => UserModel.fromJson(json),
    );

    return Right(updatedUser); // Trả về thông tin người dùng đã cập nhật thành công
  } catch (e) {
    print('Error updating user: $e');
    return Left(Failure('Lỗi không mong muốn: $e'));
  }
}


  
}
