import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:menu/features/product/models/modifiers/simple_modifier.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_item_action.dart';

class SimpleModifierWidget extends StatefulWidget {
  const SimpleModifierWidget({
    super.key,
    required this.modifier,
  });

  final SimpleModifier modifier;

  @override
  State<SimpleModifierWidget> createState() => _SimpleModifierWidgetState();
}

class _SimpleModifierWidgetState extends State<SimpleModifierWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final option in widget.modifier.options)
          InkWell(
            onTap: () {
              if (widget.modifier.contains(option)) {
                widget.modifier.removeItem(option);
              } else {
                widget.modifier.addItem(option);
              }
              setState(() {});
            },
            splashColor: Colors.white10,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                          )
                      ],
                    ),
                  ),
                  ModifierItemAction(
                    modifier: widget.modifier,
                    item: option,
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
