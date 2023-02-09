import 'package:equatable/equatable.dart';
import 'package:menu/core/extensions/num_extension.dart';
import 'package:menu/features/product/models/product.dart';

class Order extends Equatable {
  const Order({
    required this.table,
    required this.products,
    required this.userName,
    required this.userPhone,
  });

  final String table;
  final List<Product> products;
  final String userName;
  final String userPhone;

  Map<String, dynamic> toJson() {
    return {
      'table': table,
      'totalPrice': products
          .fold(0.0, (sum, product) => sum + product.total)
          .truncateFixed(2),
      'clientName': userName,
      'clientPhone': userPhone,
      'products': [
        for (final product in products)
          {
            'id': product.id,
            'basePrice': product.basePrice,
            'totalPrice': product.total.truncateFixed(2),
            'modifiers': [
              for (final modifier in product.modifiers
                  .where((modifier) => modifier.selectedOptions.isNotEmpty))
                for (final option in modifier.selectedOptions)
                  {
                    'title': '${modifier.info.title} - ${option.title}',
                    'price': option.total..truncateFixed(2),
                  }
            ],
          }
      ],
    };
  }

  @override
  List<Object?> get props => [table, products, userName, userPhone];
}
