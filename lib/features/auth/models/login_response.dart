import 'package:menu/features/auth/models/user.dart';

class LoginResponse {
  final String jwt;
  final User user;

  LoginResponse({
    required this.jwt,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return LoginResponse(
      jwt: map['jwt'] as String,
      user: User.fromJson(map['user']),
    );
  }

  LoginResponse copyWith({
    String? jwt,
    User? user,
  }) {
    return LoginResponse(
      jwt: jwt ?? this.jwt,
      user: user ?? this.user,
    );
  }
}
