import 'package:flutter/material.dart';

class Category {
  Category({
    required this.id,
    required this.title,
  });

  static Category? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final attributes = json['attributes'];
    try {
      return Category(
        id: json['id'],
        title: attributes['title'],
      );
    } catch (e, s) {
      debugPrint('Category.fromJson: $e');
      debugPrint('Category.fromJson: $s');
      return null;
    }
  }

  final int id;
  final String title;

  @override
  String toString() => 'Category(id: $id, title: $title)';
}
