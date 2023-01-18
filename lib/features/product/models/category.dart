import 'package:flutter/material.dart';

class Category {
  Category({
    required this.id,
    required this.title,
  });

  static Category? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      return Category(
        id: json['id'],
        title: json['attributes']['title'],
      );
    } catch (e, s) {
      debugPrint('Error parsing category: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }

  final int id;
  final String title;

  @override
  String toString() => 'Category(id: $id, title: $title)';
}
