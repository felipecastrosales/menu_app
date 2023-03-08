import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';

class ModifierWithCategory extends Modifier {
  ModifierWithCategory({required super.info, required this.category});

  ModifierWithCategory.fromJson(Map<String, dynamic> json)
      : category = Category.fromJson(json['category']['data'])!,
        super(
          info: ModifierInfo.fromJson(json['info']),
        );

  final Category category;
}
