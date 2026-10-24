import 'dart:ui';

Color colorFromJson(Map<String, dynamic> json) {
  return Color.fromARGB(
    json['a'] as int,
    json['r'] as int,
    json['g'] as int,
    json['b'] as int,
  );
}

extension ColorExtension on Color {
  Map<String, dynamic> toJson() {
    final argb = toARGB32();

    return {
      'a': (argb >> 24) & 0xFF,
      'r': (argb >> 16) & 0xFF,
      'g': (argb >> 8) & 0xFF,
      'b': argb & 0xFF,
    };
  }
}
