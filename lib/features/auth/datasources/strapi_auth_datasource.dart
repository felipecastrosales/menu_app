import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:menu/features/auth/models/login_response.dart';

class StrapiAuthDatasource {
  final Dio client;

  StrapiAuthDatasource(this.client);

  Future<Either<LoginError, LoginResponse>> login(
    String identifier,
    String password,
  ) async {
    try {
      final response = await client.post(
        '/auth/local',
        data: {
          'identifier': identifier,
          'password': password,
        },
      );
      return Right(LoginResponse.fromJson(response.data));
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
  unexpectedError('Ocorreu um erro inesperado');

  const LoginError(this.message);

  final String message;
}
