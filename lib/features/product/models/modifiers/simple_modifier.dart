import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';

class SimpleModifier extends Modifier {
  SimpleModifier({required super.info, required this.options});

  SimpleModifier.fromJson(Map<String, dynamic> json)
      : options = json['options']
            .map<SimpleModifierOption>((o) => SimpleModifierOption.fromJson(o))
            .toList(),
        super(
          info: ModifierInfo.fromJson(json['info']),
        );

  final List<SimpleModifierOption> options;
}

class SimpleModifierOption {
  SimpleModifierOption({required this.title, required this.price});

  SimpleModifierOption.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        price = json['price'];

  final String title;
  final num? price;
}
