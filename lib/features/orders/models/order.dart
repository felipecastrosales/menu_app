enum OrderStatus {
  delivered,
  preparing,
  paid,
}

class Order {
  final int id;
  final String table;
  final num totalPrice;
  final String userName;
  final String userPhone;
  final List<OrderProduct> products;
  final OrderStatus status;

  Order({
    required this.id,
    required this.table,
    required this.totalPrice,
    required this.userPhone,
    required this.userName,
    required this.products,
    required this.status,
  });

  factory Order.fromMap(Map<String, dynamic> json) {
    final map = json['attributes'];
    return Order(
      id: json['id'] as int,
      table: map['table'] as String,
      totalPrice: map['totalPrice'] as num,
      userPhone: map['clientPhone'] as String,
      userName: map['clientName'] as String,
      products: map['products']
          .map<OrderProduct>((e) => OrderProduct.fromMap(e))
          .toList(),
      status: OrderStatus.values.byName(map['status'] ?? 'preparing'),
    );
  }
}

class OrderProduct {
  final String title;
  final num totalPrice;
  final List<OrderProductModifier> modifiers;

  OrderProduct({
    required this.title,
    required this.totalPrice,
    required this.modifiers,
  });

  factory OrderProduct.fromMap(Map<String, dynamic> json) {
    return OrderProduct(
      title: json['product']['data']['attributes']['title'],
      totalPrice: json['totalPrice'] as num,
      modifiers: json['modifiers']
          .map<OrderProductModifier>((e) => OrderProductModifier.fromMap(e))
          .toList(),
    );
  }
}

class OrderProductModifier {
  final String title;
  final num price;

  OrderProductModifier({
    required this.title,
    required this.price,
  });

  factory OrderProductModifier.fromMap(Map<String, dynamic> json) {
    return OrderProductModifier(
      title: json['title'] as String,
      price: json['price'] as num,
    );
  }
}
