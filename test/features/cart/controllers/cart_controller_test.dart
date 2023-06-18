import 'package:flutter_test/flutter_test.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/models/create_order_model.dart';
import 'package:menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRepository extends Mock implements CartRepository {}

class MockCartPageActions extends Mock implements CartPageActions {}

class MockNotifyListeners extends Mock {
  void call();
}

class MockOrder extends Mock implements CreateOrderModel {}

void main() {
  late CartRepository cartRepository;
  late CartPageActions actions;
  late CartController controller;
  late MockNotifyListeners notifyListeners;

  const product = Product(
    id: 1,
    title: 'Title 1',
    description: 'Description 1',
    basePrice: 10.0,
    category: null,
    imageUrl: '',
    modifiers: [],
    originalBasePrice: 11.0,
  );

  setUp(() {
    cartRepository = MockCartRepository();
    actions = MockCartPageActions();
    controller = CartController(
      cartRepository: cartRepository,
      actions: actions,
    );
    notifyListeners = MockNotifyListeners();
    controller.addListener(notifyListeners);
  });

  setUpAll(() {
    registerFallbackValue(MockOrder());
  });

  tearDown(() {
    controller.removeListener(notifyListeners);
  });

  group('CartController', () {
    group('product listing', () {
      test('should add product', () {
        controller.addProduct(product);
        expect(controller.productCount, 1);
        expect(controller.products.length, 1);
        expect(controller.products, contains(product));
        verify(() => notifyListeners()).called(1);
      });

      test('should remove product', () {
        controller.addProduct(product);
        controller.removeProduct(product);
        expect(controller.products, isEmpty);
        verify(() => notifyListeners()).called(2);
      });

      test('should return total quantity', () {
        controller.addProduct(product);
        expect(controller.productCount, 1);
        controller.addProduct(product);
        expect(controller.productCount, 2);
      });

      test('should return total price in cart', () {
        controller.addProduct(product);
        expect(controller.totalPrice, 10.0);
        controller.addProduct(product);
        expect(controller.totalPrice, 20.0);
      });
    });

    group('form relateds', () {
      test(
          'should return true when is form valid case name and phone are valids',
          () {
        controller.setUserName('John Doe');
        controller.setUserPhone('(85) 12345-6789');
        expect(controller.userName, 'John Doe');
        expect(controller.userPhone, '(85) 12345-6789');
        expect(controller.isFormValid, isTrue);
        verify(() => notifyListeners()).called(2);
      });

      test(
          'should return false when form is\'nt valid case name and phone not are valids',
          () {
        controller.setUserName('');
        controller.setUserPhone('');
        expect(controller.userName, '');
        expect(controller.userPhone, '');
        expect(controller.isFormValid, isFalse);
        verify(() => notifyListeners()).called(2);
      });
    });

    group('sets', () {
      test('should set table', () {
        const table = '1';
        controller.setTable(table);
        expect(controller.table, table);
      });

      test('should set actions', () {
        final actions = MockCartPageActions();
        controller.setActions(actions);
        expect(controller.actions, actions);
      });

      test('should set user name', () {
        const name = 'John Doe';
        controller.setUserName(name);
        expect(controller.userName, name);
      });

      test('should set user phone', () {
        const phone = '123456789';
        controller.setUserPhone(phone);
        expect(controller.userPhone, phone);
      });
    });

    group('create orders', () {
      test(
          'in success case when create order, should clear the cart and redirect to home',
          () async {
        const tOrder = CreateOrderModel(
          products: [product],
          table: '1',
          userName: 'John Doe',
          userPhone: '(85) 12345-6789',
        );

        when(() => cartRepository.createOrder(tOrder))
            .thenAnswer((_) async => 1);

        controller.addProduct(product);
        controller.setTable('1');
        controller.setUserName('John Doe');
        controller.setUserPhone('(85) 12345-6789');

        verify(() => notifyListeners()).called(3);

        await controller.sendOrder();

        expect(controller.products, isEmpty);
        expect(controller.loading, isFalse);

        verify(() => actions.goToHome()).called(1);
        verify(() => notifyListeners()).called(2);

        verifyNoMoreInteractions(actions);
      });

      test(
          'should show message error and keep intact cart when has error in product creation',
          () async {
        when(() => cartRepository.createOrder(any())).thenThrow(Exception());

        controller.addProduct(product);
        controller.setTable('1');

        verify(() => notifyListeners()).called(1);

        await controller.sendOrder();

        expect(controller.products, isNotEmpty);
        expect(controller.loading, isFalse);

        verify(() => actions.showErrorMessage()).called(1);
        verify(() => notifyListeners()).called(2);

        verifyNoMoreInteractions(actions);
      });

      test('should put actions as null when make dispose', () {
        controller.dispose();
        expect(controller.actions, isNull);
        verifyNoMoreInteractions(actions);
      });
    });
  });
}
