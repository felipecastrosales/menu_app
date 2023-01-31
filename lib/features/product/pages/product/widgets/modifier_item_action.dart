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
          if (modifier.count(item) > 0) ...[
            IconButton(
              onPressed: () {
                modifier.removeItem(item);
              },
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.remove),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                modifier.count(item).toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
          IconButton(
            onPressed: () {
              modifier.addItem(item);
            },
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.add),
          ),
        ],
      );
    } else {
      return Checkbox(
        value: modifier.contains(item),
        onChanged: modifier.canAddItem || modifier.contains(item)
            ? (b) {
                if (!b!) {
                  modifier.removeItem(item);
                } else {
                  modifier.addItem(item);
                }
              }
            : null,
        fillColor: MaterialStateProperty.all(
          modifier.canAddItem || modifier.contains(item)
              ? Theme.of(context).primaryColor
              : Colors.grey[800],
        ),
      );
    }
  }
}
