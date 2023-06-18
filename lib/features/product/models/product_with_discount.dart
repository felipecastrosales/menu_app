import 'package:equatable/equatable.dart';

import 'package:menu/features/product/models/modifier_item.dart';
import 'package:menu/features/product/models/product.dart';

class ProductWithDiscount extends Equatable implements ModifierItem {
  const ProductWithDiscount({
    required this.product,
    required this.discountPercentage,
    required this.availableWeekdays,
  });

  static ProductWithDiscount? fromJson(Map<String, dynamic> json) {
    try {
      return ProductWithDiscount(
        product: Product.fromJson(json['product']['data'])!,
        discountPercentage: json['discountPercentage'],
        availableWeekdays: json['availableWeekdays']['data']
            .map<Weekday>((w) => Weekday.fromMap(w))
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }

  final Product product;
  final num discountPercentage;
  final List<Weekday> availableWeekdays;

  @override
  num get total => product.basePrice * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [product.id, discountPercentage];

  @override
  String get title => product.title;
}

class Weekday {
  const Weekday({
    required this.name,
    required this.number,
  });

  final String name;
  final int number;

  factory Weekday.fromMap(Map<String, dynamic> map) {
    return Weekday(
      name: map['attributes']['title'] as String,
      number: map['attributes']['number'] as int,
    );
  }
}
