import 'package:flutter/material.dart';

class CorePageTitle extends StatelessWidget {
  const CorePageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Felipe\'s Menu',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Mesa 1',
            style: TextStyle(
              color: Color(0xff5f6066),
            ),
          ),
        ],
      ),
    );
  }
}
