import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menu/features/home/models/home_banner_section.dart';

class HomeBannerSectionWidget extends StatelessWidget {
  const HomeBannerSectionWidget({
    super.key,
    required this.section,
  });

  final HomeBannerSection section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: section.size == HomeBannerSize.small ? 100 : 200,
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  context.pushNamed('/products/${section.productId}');
                },
                child: Image.network(
                  section.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
