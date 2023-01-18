class ModifierInfo {
  ModifierInfo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        minQuantity = json['minQuantity'],
        maxQuantity = json['maxQuantity'],
        allowRepeated = json['allowRepeated'] ?? false;

  final String title;
  final int minQuantity;
  final int? maxQuantity;
  final bool allowRepeated;

  @override
  String toString() =>
      'ModifierInfo(title: $title, minQuantity: $minQuantity, maxQuantity: $maxQuantity, allowRepeated: $allowRepeated)';
}
