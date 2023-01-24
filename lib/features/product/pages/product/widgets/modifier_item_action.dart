import 'package:flutter/material.dart';

import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_item.dart';

class ModifierItemAction extends StatelessWidget {
  const ModifierItemAction({
    super.key,
    required this.modifier,
    required this.item,
  });

  final Modifier modifier;
  final ModifierItem item;

  @override
  Widget build(BuildContext context) {
    if (modifier.info.allowRepeated) {
      return Row(
        children: [
          IconButton(
            onPressed: () {},
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.remove),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '0',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.add),
          ),
        ],
      );
    } else {
      return Checkbox(
        value: modifier.contains(item),
        onChanged: (b) {
          if (b!) {
            modifier.removeItem(item);
          } else {
            modifier.addItem(item);
          }
        },
        fillColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor,
        ),
      );
    }
  }
}
