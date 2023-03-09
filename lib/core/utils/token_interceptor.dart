import 'package:dio/dio.dart';
import 'package:menu/features/auth/repository/auth_repository.dart';

class TokenInterceptor extends Interceptor {
  final AuthRepository _authRepository;

  TokenInterceptor(this._authRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authRepository.isLoggedIn) {
      options.headers['Authorization'] = 'Bearer ${_authRepository.jwt}';
    }
    super.onRequest(options, handler);
  }
}
