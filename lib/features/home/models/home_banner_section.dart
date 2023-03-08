import 'package:menu/core/extensions/string_extension.dart';
import 'package:menu/features/home/models/home_section.dart';

enum HomeBannerSize { small, big }

class HomeBannerSection extends HomeSection {
  HomeBannerSection({
    required this.title,
    required this.size,
    required this.imageUrl,
    required this.productId,
  });

  static HomeBannerSection fromJson(Map<String, dynamic> json) {
    return HomeBannerSection(
      title: json['title'],
      size: HomeBannerSize.values.byName(json['size']),
      imageUrl:
          'http://localhost:1337${json['image']['data']['attributes']['url']}',
      productId: json['product']['data']['id'],
    );
  }

  final String title;
  final HomeBannerSize size;
  final String imageUrl;
  final int productId;

  @override
  HomeSection? copyFiltered(String search) {
    if (title.clear.contains(search)) {
      return this;
    } else {
      return null;
    }
  }
}
