import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:momentsy/core/config/api/api_endpoint.dart';
import 'package:momentsy/core/config/api/api_service.dart';
import 'package:momentsy/core/exception/failure.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/data/body/reset_password_body.dart';
import 'package:momentsy/app/data/body/verify_otp_body.dart';
import 'package:momentsy/app/data/models/login_response.dart';
import 'package:momentsy/app/data/models/verify_otp_response.dart';

abstract class IAuthService {
  Future<Either<Failure, String>> register(RegisterBody body);
  Future<Either<Failure, LoginModel>> login(LoginBody body);
  Future<Either<Failure, String>> sendOtp(String email);
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(VerifyOtpBody body);
  Future<Either<Failure, String>> resetPassword(ResetPasswordBody body);
}

class AuthService extends ApiService implements IAuthService {
  AuthService() : super();
  @override
  Future<Either<Failure, String>> register(RegisterBody body) async {
    try {
      final response = await post(ApiEndpoint.register, data: body.toJson());
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(LoginBody body) async {
    try {
      final response = await post(ApiEndpoint.login, data: body.toJson());
      return Right(LoginModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      final response = await post(
        ApiEndpoint.forgotPassword,
        data: {"email": email},
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(VerifyOtpBody body) async {
    try {
      final response = await post(ApiEndpoint.verifyOTP, data: body.toJson());
      return Right(VerifyOtpModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPasswordBody body) async {
    try {
      final response = await post(
        ApiEndpoint.resetPassword,
        data: body.toJson(),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(Failure("Lỗi không mong muốn: ${e.toString()}"));
    }
  }
}
