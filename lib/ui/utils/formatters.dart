import 'package:intl/intl.dart';

final NumberFormat _currencyFormat = NumberFormat("#,##0.00", "es_PE");
final NumberFormat _numberFormat = NumberFormat('#,##0.##', 'es_PE');
final DateFormat _dateFormat = DateFormat('dd/MM/yyyy', 'es_PE');

/// Format currency without currency symbol
String formatCurrency(dynamic value) {
  if (value == null || value.toString().isEmpty) return "0.00";
  final parsed = double.tryParse(value.toString()) ?? 0.0;
  return _currencyFormat.format(parsed);
}

/// Format number with thousand separators
String formatNumber(dynamic value) {
  if (value == null || value.toString().isEmpty) return "0";
  final parsed = double.tryParse(value.toString()) ?? 0.0;
  return _numberFormat.format(parsed);
}

/// Format percentage correctly (Sheets stores 100% as 1, 50% as 0.5)
String formatPercentage(dynamic value) {
  if (value == null) return "0%";
  try {
    double val = value is num
        ? value.toDouble()
        : double.parse(value.toString());
    if (val <= 1) val *= 100;
    return "${val.toStringAsFixed(0)}%";
  } catch (_) {
    return "0%";
  }
}

/// Format date as dd/MM/yyyy
String formatDate(dynamic value) {
  if (value == null || value.toString().isEmpty) return "";
  try {
    if (value is DateTime) return _dateFormat.format(value);
    return _dateFormat.format(DateTime.parse(value.toString()));
  } catch (_) {
    return value.toString();
  }
}

/// Format date as "dd.MM, weekday" (for reportes card)
String formatDateWithWeekday(dynamic value) {
  if (value == null) return "";
  try {
    final date = value is DateTime ? value : DateTime.parse(value.toString());
    const weekdays = [
      "lunes",
      "martes",
      "miércoles",
      "jueves",
      "viernes",
      "sábado",
      "domingo",
    ];
    final weekday = weekdays[date.weekday - 1];
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}, $weekday";
  } catch (_) {
    return value.toString();
  }
}

/// Format distance with 1 decimal place
String formatDistance(dynamic value) {
  if (value == null) return "0.0 km";
  try {
    final parsed = value is num
        ? value.toDouble()
        : double.parse(value.toString());
    return "${parsed.toStringAsFixed(1)} km";
  } catch (_) {
    return "0.0 km";
  }
}
