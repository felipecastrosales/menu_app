import 'package:menu/features/auth/datasources/strapi_auth_datasource.dart';

abstract class AuthPageActions {
  void navToDashboard();
  void showErrorMessage(LoginError error);
}
