import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/home/repositories/home_repository.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

final getIt = GetIt.I;

void configureDependencies() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:1337/api',
      headers: {
        'Authorization':
            'Bearer b6a464ba96672e15589c6682100cefaecf50dbe24305b0993ba8ddd5f1a828e897e8a40a72a793a169fb3795966f7cdda60d62ee40583d78d27bc346291116c879f9c84de2af2373ff26355974265298248d76789a03d996e71f84cba003ecf9a511d496e962884454e48b3a97c03446c1816d3713d600483d4678c7e745714c'
      },
    ),
  );

  getIt.registerSingleton(dio);
  getIt.registerFactory<StrapiDatasource>(() => StrapiDatasourceImpl(getIt()));
  getIt.registerFactory(() => CartRepository(getIt()));
  getIt.registerFactory<ProductRepository>(
    () => StrapiProductRepository(getIt()),
  );
  getIt.registerFactory(() => HomeRepository(getIt()));
}
