extension NumX on num {
  num truncateFixed(int decimals) {
    return num.parse(decimals.toStringAsFixed(2));
  }
}
