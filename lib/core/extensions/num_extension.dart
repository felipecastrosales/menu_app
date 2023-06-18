extension NumX on num {
  num truncateFixed(int decimals) => num.parse(toStringAsFixed(decimals));
}
