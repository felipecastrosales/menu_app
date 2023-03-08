import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late StrapiDatasource datasource;

  setUp(() {
    dio = MockDio();
    datasource = StrapiDatasourceImpl(dio);
  });

  group('getProduct', () {
    test('Should returns Product model when success', () async {
      // Arrange
      when(
        () => dio.get(
          '/products/5',
          queryParameters: {
            'populate': 'deep',
          },
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(
            File('test/fixtures/get_product_response.json').readAsStringSync(),
          ),
        ),
      );

      // Act
      final result = await datasource.getProduct(5);

      // Assert
      expect(result.isRight, true);
    });

    test('Should return notFound when Product not found', () async {
      // Arrange
      when(
        () => dio.get(
          '/products/5',
          queryParameters: {
            'populate': 'deep',
          },
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.response,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
          ),
        ),
      );

      // Act
      final result = await datasource.getProduct(5);

      // Assert
      expect(result.isLeft, true);
      expect(result.left, GetProductError.notFound);
    });

    test('Should return notFound when is unknown error', () async {
      // Arrange
      when(
        () => dio.get(
          '/products/5',
          queryParameters: {
            'populate': 'deep',
          },
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.response,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
          ),
        ),
      );

      // Act
      final result = await datasource.getProduct(5);

      // Assert
      expect(result.isLeft, true);
      expect(result.left, GetProductError.unknown);
    });
  });
}
