import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:menu/core/utils/token_interceptor.dart';
import 'package:menu/features/auth/datasources/strapi_auth_datasource.dart';
import 'package:menu/features/auth/repositories/auth_repository.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/home/repositories/home_repository.dart';
import 'package:menu/features/order/repositories/order_repository.dart';

class CoreBindings implements Bindings {
  @override
  void dependencies() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:1338/api',
        headers: {
          'Authorization':
              'Bearer 41519b9fc135e171495b227fc79e79de81bb92bd50d5dfb251fb60404d0066f510f290a8b8d61094e1968bcf68255c99b2a2c87e63be1cca4bd8e309b249a55ad852fa1d3f8ef881b96dad535fffd9187fb04861cd95623d60bc737aed827898adc21f90d59cdf8197ac2bfc29e43cd9e34b70925631bb01b80a93c85155f99b',
        },
      ),
    );

    Get.put(dio);
    Get.lazyPut<StrapiDatasource>(() => StrapiDatasourceImpl(Get.find()));
    Get.lazyPut<StrapiAuthDatasource>(() => StrapiAuthDatasource(Get.find()));
    Get.lazyPut(() => CartRepository(Get.find()));
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.put(OrderRepository(Get.find()), permanent: true);
    Get.put(AuthRepository(Get.find()), permanent: true);
    Get.lazyPut(() => CartController());

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
      TokenInterceptor(Get.find()),
    ]);
  }
}
