import 'package:flutter_test/flutter_test.dart';
import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';

void main() {
  late Modifier modifier;

  final modifierInfo = ModifierInfo(
    title: 'Title 1',
    minQuantity: 1,
    maxQuantity: null,
    allowRepeated: false,
  );

  group('Simple Modifier', () {});

  test('case Modifier not allow repeated, not include repeated', () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo.copyWith(allowRepeated: false),
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));
    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));

    expect(modifier.selectedOptions.length, 1);
    expect(modifier.selectedOptions.first.title, 'Option 1');
    expect(modifier.selectedOptions.first.total, 0);
  });

  test('case Modifier allow repeated, include repeated', () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo.copyWith(allowRepeated: true),
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));
    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));

    expect(modifier.selectedOptions.length, 2);
    expect(modifier.selectedOptions.first.title, 'Option 1');
    expect(modifier.selectedOptions.first.total, 0);
    expect(modifier.selectedOptions.last.title, 'Option 1');
    expect(modifier.selectedOptions.last.total, 0);
  });

  test('case Modifier allow only 1 options, should include new and exclude old',
      () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo.copyWith(maxQuantity: 1),
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));
    modifier.addItem(const SimpleModifierOption(title: 'Option 2'));

    expect(modifier.selectedOptions.length, 1);
    expect(modifier.selectedOptions.first.title, 'Option 2');
    expect(
      modifier.selectedOptions,
      contains(const SimpleModifierOption(title: 'Option 2')),
    );
  });

  test('case Modifier allow only more than 1 options, should include new', () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo.copyWith(maxQuantity: 2),
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));
    modifier.addItem(const SimpleModifierOption(title: 'Option 2'));

    expect(modifier.selectedOptions.length, 2);

    expect(
      modifier.selectedOptions,
      contains(const SimpleModifierOption(title: 'Option 1')),
    );

    expect(
      modifier.selectedOptions,
      contains(const SimpleModifierOption(title: 'Option 2')),
    );
  });

  test('should return false in canAddItem case already have maxQuantity', () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo.copyWith(maxQuantity: 1),
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));

    expect(modifier.canAddItem, false);
  });

  test('should return true in canAddItem case not have maxQuantity', () {
    modifier = SimpleModifier.forTest(
      info: modifierInfo,
    );

    modifier.addItem(const SimpleModifierOption(title: 'Option 1'));

    expect(modifier.canAddItem, true);
  });
}
