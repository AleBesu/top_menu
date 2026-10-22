import 'dart:math';

const _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
final _rnd = Random();

String uid() =>
    List.generate(7, (_) => _chars[_rnd.nextInt(_chars.length)]).join();

/// "12" -> "12.00 €"
String formatPrice(String raw) {
  final v = double.tryParse(raw.replaceAll(',', '.'));
  return v == null ? '$raw €' : '${v.toStringAsFixed(2)} €';
}
