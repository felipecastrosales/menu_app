import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';

class MockStrapiDatasource extends Mock implements StrapiDatasource {}

class OrderFake extends Fake implements Order {}

void main() {
  late StrapiDatasource datasource = MockStrapiDatasource();
  late CartRepository cartRepository = CartRepository(datasource);

  setUp(() {
    datasource = MockStrapiDatasource();
    cartRepository = CartRepository(datasource);
  });

  setUpAll(() {
    registerFallbackValue(OrderFake());
  });

  group('Success tests', () {
    setUp(() {
      when(() => datasource.createOrder(any())).thenAnswer((_) async => 1);
    });

    test('Should returns order id when create order with success', () async {
      // arrange
      const tOrder = Order(
        table: '1',
        products: [],
        userName: 'userName',
        userPhone: 'userPhone',
      );

      // act
      final result = await cartRepository.createOrder(tOrder);

      // assert
      expect(result, 1);
      verify(() => datasource.createOrder(tOrder)).called(1);
    });
  });

  group('Failure tests', () {
    setUp(() {
      when(() => datasource.createOrder(any())).thenThrow(Exception());
    });

    test('Should returns exception if has error in create order', () async {
      // arrange
      const tOrder = Order(
        table: '1',
        products: [],
        userName: 'userName',
        userPhone: 'userPhone',
      );

      // assert
      expect(
        () async => await cartRepository.createOrder(tOrder),
        throwsA(isA<Exception>()),
      );

      verify(() => datasource.createOrder(tOrder)).called(1);
    });
  });
}
