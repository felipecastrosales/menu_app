import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:menu/features/auth/models/login_response.dart';

class StrapiAuthDatasource {
  StrapiAuthDatasource(this._dio);

  final Dio _dio;

  Future<Either<LoginError, LoginResponse>> login(
    String identifier,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/local',
        data: {
          'identifier': identifier,
          'password': password,
        },
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      return Right(loginResponse);
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        return const Left(LoginError.invalidCredentials);
      }
      return const Left(LoginError.unexpectedError);
    }
  }
}

enum LoginError {
  invalidCredentials('As credenciais inseridas são inválidas'),
  unexpectedError('Um erro inesperado ocorreu');

  const LoginError(this.message);
  final String message;
}
