import 'package:either_dart/either.dart';
import 'package:menu/features/auth/datasources/strapi_auth_datasource.dart';
import 'package:menu/features/auth/models/login_response.dart';
import 'package:menu/features/auth/models/user.dart';

class AuthRepository {
  AuthRepository(this._datasource);
  final StrapiAuthDatasource _datasource;

  String? jwt;
  User? user;
  bool get isLoggedIn => jwt != null;

  Future<Either<LoginError, LoginResponse>> login(
    String identifier,
    String password,
  ) async {
    final result = await _datasource.login(identifier, password);
    if (result.isRight) {
      jwt = result.right.jwt;
      user = result.right.user;
    }
    return result;
  }
}
