import 'package:flutter/material.dart';

class CorePageTitle extends StatelessWidget {
  const CorePageTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mesa 1',
            style: TextStyle(color: Color(0xff5f6066)),
          )
        ],
      ),
    );
  }
}
