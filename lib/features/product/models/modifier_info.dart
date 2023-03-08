class ModifierInfo {
  ModifierInfo({
    required this.title,
    required this.minQuantity,
    this.maxQuantity,
    required this.allowRepeated,
  });

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
  String toString() {
    return 'ModifierInfo{title: $title, minQuantity: $minQuantity, maxQuantity: $maxQuantity, allowRepeated: $allowRepeated}';
  }

  ModifierInfo copyWith({
    String? title,
    int? minQuantity,
    int? maxQuantity,
    bool? allowRepeated,
  }) {
    return ModifierInfo(
      title: title ?? this.title,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      allowRepeated: allowRepeated ?? this.allowRepeated,
    );
  }
}
