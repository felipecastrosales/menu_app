import 'package:flutter/foundation.dart';

class Category {
  Category({required this.id, required this.title});

  static Category? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      return Category(
        id: json['id'],
        title: json['attributes']['title'],
      );
    } catch (e, s) {
      //debugPrint('$e $s');
      return null;
    }
  }

  final int id;
  final String title;

  @override
  String toString() {
    return 'Category{id: $id, title: $title}';
  }
}
