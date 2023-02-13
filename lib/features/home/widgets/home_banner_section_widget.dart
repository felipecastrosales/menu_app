import 'package:flutter/material.dart';
import 'package:menu/features/home/models/home_banner_section.dart';
import 'package:go_router/go_router.dart';

class HomeBannerSectionWidget extends StatelessWidget {
  const HomeBannerSectionWidget({
    Key? key,
    required this.section,
  }) : super(key: key);

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
            height: section.size == HomeBannerSize.big ? 240 : 120,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  context.push('/products/${section.productId}');
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
