import 'package:intl/intl.dart';

final NumberFormat _currencyFormat = NumberFormat.currency(
  locale: 'es_PE',
  symbol: 'S/.',
  decimalDigits: 2,
);

final NumberFormat _numberFormat = NumberFormat('#,##0.##', 'es_PE');
final DateFormat _dateFormat = DateFormat('dd/MM/yyyy', 'es_PE');

String formatCurrency(dynamic value) {
  if (value == null || value.toString().isEmpty) return "S/. 0.00";
  final parsed = double.tryParse(value.toString()) ?? 0.0;
  return _currencyFormat.format(parsed);
}

String formatNumber(dynamic value) {
  if (value == null || value.toString().isEmpty) return "0";
  final parsed = double.tryParse(value.toString()) ?? 0.0;
  return _numberFormat.format(parsed);
}

String formatDate(dynamic value) {
  if (value == null || value.toString().isEmpty) return "";
  try {
    if (value is DateTime) return _dateFormat.format(value);
    return _dateFormat.format(DateTime.parse(value.toString()));
  } catch (_) {
    return value.toString();
  }
}