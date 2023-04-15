import 'package:dio/dio.dart';

import 'package:menu/features/auth/repositories/auth_repository.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(this._authRepository);
  final AuthRepository _authRepository;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_authRepository.isLoggedIn) {
      options.headers['Authorization'] = 'Bearer ${_authRepository.jwt}';
    }
    super.onRequest(options, handler);
  }
}
