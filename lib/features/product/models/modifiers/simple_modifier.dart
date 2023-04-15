import 'package:flutter/cupertino.dart';

import 'package:equatable/equatable.dart';

import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/modifier_item.dart';

class SimpleModifier extends Modifier {
  SimpleModifier({
    required super.info,
    required this.options,
  });

  @visibleForTesting
  SimpleModifier.forTest({
    required super.info,
    this.options = const [],
  });

  SimpleModifier.fromJson(Map<String, dynamic> json)
      : options = json['options']
            .map<SimpleModifierOption>((o) => SimpleModifierOption.fromJson(o))
            .toList(),
        super(
          info: ModifierInfo.fromJson(json['info']),
        );

  final List<SimpleModifierOption> options;
}

class SimpleModifierOption extends Equatable implements ModifierItem {
  const SimpleModifierOption({required this.title, this.price});

  SimpleModifierOption.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        price = json['price'];

  @override
  final String title;

  final num? price;

  @override
  num get total => price ?? 0;

  @override
  List<Object?> get props => [title, price];
}
