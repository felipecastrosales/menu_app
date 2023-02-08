import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoreTextField extends StatelessWidget {
  const CoreTextField({
    super.key,
    required this.title,
    required this.hint,
    this.textInputType,
    this.formatters,
    this.onChanged,
    this.initialValue,
  });

  final String title;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formatters;
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF393c44),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: textInputType,
            inputFormatters: formatters,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              isCollapsed: true,
              filled: true,
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
