import 'package:menu/features/auth/models/user.dart';

class LoginResponse {
  const LoginResponse({
    required this.jwt,
    required this.user,
  });

  final String jwt;
  final User user;

  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return LoginResponse(
      jwt: map['jwt'] as String,
      user: User.fromJson(map['user']),
    );
  }
}
