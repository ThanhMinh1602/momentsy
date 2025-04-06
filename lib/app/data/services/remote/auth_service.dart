import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:momentsy/app/data/models/base/base_model.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exceptions/failure.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/data/body/reset_password_body.dart';
import 'package:momentsy/app/data/body/verify_otp_body.dart';
import 'package:momentsy/app/data/models/login_model.dart';
import 'package:momentsy/app/data/models/verify_otp_model.dart';

abstract class IAuthService {
  Future<Either<Failure, BaseModel>> register(RegisterBody body);
  Future<Either<Failure, BaseModel<LoginModel>>> login(LoginBody body);
  Future<Either<Failure, BaseModel>> sendOtp(String email);
  Future<Either<Failure, BaseModel<VerifyOtpModel>>> verifyOtp(
    VerifyOtpBody body,
  );
  Future<Either<Failure, BaseModel>> resetPassword(ResetPasswordBody body);
  Future<Either<Failure, BaseModel>> logout(String userId);
}

class AuthService extends ApiService implements IAuthService {
  AuthService() : super();
  @override
  Future<Either<Failure, BaseModel>> register(RegisterBody body) async {
    try {
      final response = await post(ApiEndpoint.register, data: body.toJson());
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseModel<LoginModel>>> login(LoginBody body) async {
    try {
      final response = await post(ApiEndpoint.login, data: body.toJson());
      return Right(
        BaseModel<LoginModel>.fromJson(
          response.data,
          dataFromJson: (json) => LoginModel.fromJson(json),
        ),
      );
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseModel>> sendOtp(String email) async {
    try {
      final response = await post(
        ApiEndpoint.forgotPassword,
        data: {"email": email},
      );
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseModel<VerifyOtpModel>>> verifyOtp(
    VerifyOtpBody body,
  ) async {
    try {
      final response = await post(ApiEndpoint.verifyOTP, data: body.toJson());
      return Right(
        BaseModel<VerifyOtpModel>.fromJson(
          response.data,
          dataFromJson: (json) => VerifyOtpModel.fromJson(json),
        ),
      );
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseModel>> resetPassword(
    ResetPasswordBody body,
  ) async {
    try {
      final response = await post(
        ApiEndpoint.resetPassword,
        data: body.toJson(),
      );
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BaseModel>> logout(String userId) async {
    try {
      final response = await post(ApiEndpoint.logout, data: {'userId': userId});
      return Right(BaseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }
}
