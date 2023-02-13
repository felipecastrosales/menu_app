import 'package:equatable/equatable.dart';

import 'package:menu/core/extensions/num_extension.dart';
import 'package:menu/features/product/models/product.dart';

class Order extends Equatable {
  const Order({
    required this.table,
    required this.products,
    required this.userPhone,
    required this.userName,
  });

  final String table;
  final List<Product> products;
  final String userName;
  final String userPhone;

  Map<String, dynamic> toJson() {
    return {
      'table': table,
      'totalPrice': products
          .fold(0.0, (previousValue, element) => previousValue + element.total)
          .truncateFixed(2),
      'clientName': userName,
      'clientPhone': userPhone,
      'products': [
        for (final p in products)
          {
            'product': p.id,
            'basePrice': p.basePrice,
            'totalPrice': p.total.truncateFixed(2),
            'modifiers': [
              for (final m
                  in p.modifiers.where((m) => m.selectedOptions.isNotEmpty))
                for (final option in m.selectedOptions)
                  {
                    'title': '${m.info.title} - ${option.title}',
                    'price': option.total.truncateFixed(2),
                  }
            ]
          }
      ],
    };
  }

  @override
  List<Object?> get props => [table, products, userName, userPhone];
}
