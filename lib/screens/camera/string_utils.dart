double getNumberFromText(String text) {
  if (text.contains(',') && text.contains('.')) {
    // 1,050.00 -> 1050.00
    text = text.replaceAll(',', '').replaceAll('.', '.');
  } else if (text.contains(',')) {
    if (text.indexOf(',') < text.length - 3) {
      // 1,050 -> 1050
      text = text.replaceAll(',', '');
    } else {
      // 1050,00 -> 1050.00
      text = text.replaceAll(',', '.');
    }
  } else if (text.contains('.')) {
    if (text.indexOf('.') < text.length - 3) {
      // 1.050 -> 1050
      text = text.replaceAll('.', '');
    } else {
      // 1050.00 -> 1050.00
      text = text.replaceAll('.', '.');
    }
  }
  return double.tryParse(text) ?? 0.0;
}
