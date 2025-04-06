import 'package:dartz/dartz.dart';
import 'package:momentsy/app/data/models/base/base_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exceptions/failure.dart';

abstract class IUserService {
  Future<Either<Failure, BaseModel<UserModel>>> getUserById(String userId);
  Future<void> updateUser(UserModel user);
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
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
