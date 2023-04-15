enum OrderStatus { preparing, delivered, paid }

class Order {
  Order({
    required this.id,
    required this.table,
    required this.totalPrice,
    required this.clientName,
    required this.clientPhone,
    required this.products,
    required this.status,
    required this.createdAt,
  });

  final int id;
  final String table;
  late num totalPrice;
  final String clientName;
  final String clientPhone;
  final List<OrderProduct> products;
  final OrderStatus status;
  final DateTime createdAt;

  factory Order.fromMap(Map<String, dynamic> json) {
    final map = json['attributes'];

    return Order(
      id: json['id'] as int,
      table: map['table'] as String,
      totalPrice: map['totalPrice'] as num,
      clientName: map['clientName'] as String,
      clientPhone: map['clientPhone'] as String,
      products: map['products']
          .map<OrderProduct>((p) => OrderProduct.fromMap(p))
          .toList(),
      status: OrderStatus.values.byName(map['status'] ?? 'preparing'),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  void addOrder(Order order) {
    products.addAll(order.products);
    totalPrice += order.totalPrice;
  }

  @override
  String toString() {
    return 'Order(id: $id, table: $table, clientName: $clientName, clientPhone: $clientPhone, products: $products, status: $status, createdAt: $createdAt)';
  }
}

class OrderProduct {
  const OrderProduct({
    required this.title,
    required this.totalPrice,
    required this.modifiers,
  });

  final String title;
  final num totalPrice;
  final List<OrderProductModifier> modifiers;

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      title: map['product']['data']['attributes']['title'] as String,
      totalPrice: map['totalPrice'] as num,
      modifiers: map['modifiers']
          .map<OrderProductModifier>((m) => OrderProductModifier.fromMap(m))
          .toList(),
    );
  }

  @override
  String toString() =>
      'OrderProduct(title: $title, totalPrice: $totalPrice, modifiers: $modifiers)';
}

class OrderProductModifier {
  const OrderProductModifier({
    required this.title,
    required this.price,
  });

  final String title;
  final num price;

  @override
  String toString() {
    return 'OrderProductModifier{ title: $title, price: $price,}';
  }

  factory OrderProductModifier.fromMap(Map<String, dynamic> map) {
    return OrderProductModifier(
      title: map['title'] as String,
      price: map['price'] as num,
    );
  }
}
