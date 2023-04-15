import 'package:flutter/material.dart';

class CoreElevatedButton extends StatelessWidget {
  const CoreElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    this.color,
  });

  final VoidCallback? onPressed;
  final String title;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        disabledBackgroundColor: Colors.grey[800]!.withOpacity(0.7),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        title,
      ),
    );
  }
}
