import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_item_action.dart';
import 'package:provider/provider.dart';

class SimpleModifierWidget extends StatelessWidget {
  const SimpleModifierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleModifier>(
      builder: (_, modifier, __) {
        return ListView(
          shrinkWrap: true,
          children: [
            for (final option in modifier.options)
              InkWell(
                onTap: modifier.canAddItem || modifier.contains(option)
                    ? () {
                        if (modifier.contains(option)) {
                          modifier.removeItem(option);
                        } else {
                          modifier.addItem(option);
                        }
                      }
                    : null,
                splashColor: Colors.white10,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            if (option.price != null)
                              Text(
                                '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(option.price!)}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      ModifierItemAction(
                        modifier: modifier,
                        item: option,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
