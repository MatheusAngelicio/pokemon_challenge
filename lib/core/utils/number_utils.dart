double parseDoubleFromString(String s) {
  final cleaned = s.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(cleaned) ?? 0;
}
