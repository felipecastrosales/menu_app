import 'package:equatable/equatable.dart';
import 'package:menu/features/product/models/modifier_item.dart';
import 'package:menu/features/product/models/product.dart';

class ProductWithDiscount extends Equatable implements ModifierItem {
  const ProductWithDiscount({
    required this.product,
    required this.discountPercentage,
  });

  static ProductWithDiscount? fromJson(Map<String, dynamic> json) {
    try {
      return ProductWithDiscount(
        product: Product.fromJson(json['product']['data'])!,
        discountPercentage: json['discountPercentage'],
      );
    } catch (e) {
      return null;
    }
  }

  final Product product;
  final num discountPercentage;

  @override
  num get total => product.basePrice * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [product.id, discountPercentage];

  @override
  String get title => product.title;
}
