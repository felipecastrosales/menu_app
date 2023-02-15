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
            'Bearer e3e138cf15a45aef7c6e287c6f41b0763f7dbe6e5bcd37481f6e10d767a70be2bbdc5eb9866cfd26e7f0ae8d6ce74437f39cd8e263e37dd321a1e34aed4e071af9f6f20ed8d5ab2b5bd8105bd1ae42f6c8c4c8eae937399418cdfcf845598ee7f634e16c062ba677e715801e7699354911f2b63ca8fe7b2108432bce979bb674'
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
