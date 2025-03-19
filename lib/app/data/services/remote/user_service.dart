// import 'package:dartz/dartz.dart';
// import 'package:momentsy/app/data/models/user_model.dart';
// import 'package:momentsy/core/config/api_service.dart';
// import 'package:momentsy/core/exception/failure.dart';

// abstract class IUserService {
//   Future<Either<Failure, UserModel>> getUserById(String userId);
//   Future<void> updateUser(UserModel user);
// }

// class UserService extends ApiService implements IUserService {
//   @override
//   Future<Either<Failure, UserModel>> getUserById(String userId) {
//     try {
//       // final response = await get(ApiEndpoint.getUserById + userId);
//       // final user = UserModel.fromJson(response.data);
//       // return Right(user);
//       throw Exception();
//     } catch (e) {
//       return Left(Failure('Lỗi không mong muốn: $e'));
//     }
//   }

//   @override
//   Future<void> updateUser(UserModel user) {
//     // TODO: implement updateUser
//     throw UnimplementedError();
//   }
// }
