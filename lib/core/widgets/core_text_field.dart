import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoreTextField extends StatelessWidget {
  const CoreTextField({
    super.key,
    required this.title,
    required this.hint,
    this.textInputType,
    this.formatters,
    required this.onChanged,
    this.initialValue,
    this.obscure = false,
  });

  final String? initialValue;
  final String title;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formatters;
  final Function(String) onChanged;
  final bool obscure;

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
            color: const Color(0xff2a2e3d),
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            keyboardType: textInputType,
            inputFormatters: formatters,
            onChanged: onChanged,
            obscureText: obscure,
          ),
        )
      ],
    );
  }
}
