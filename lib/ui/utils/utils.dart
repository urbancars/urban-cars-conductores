import 'package:intl/intl.dart';

/// Format money with thousand separators and 2 decimals
String formatMoney(dynamic value) {
  if (value == null) return "0.00";
  try {
    final num number = value is num ? value : num.parse(value.toString());
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  } catch (_) {
    return "0.00";
  }
}

/// Format date into "dd.MM, weekday"
String formatDate(dynamic value) {
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
      "domingo"
    ];
    final weekday = weekdays[date.weekday - 1];
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}, $weekday";
  } catch (_) {
    return value.toString();
  }
}

/// Format percentage correctly (Google Sheets stores 100% as 1, 50% as 0.5)
String formatPercentage(dynamic value) {
  if (value == null) return "0%";
  try {
    double val = value is num ? value.toDouble() : double.parse(value.toString());
    if (val <= 1) val *= 100;
    return "${val.toStringAsFixed(0)}%";
  } catch (_) {
    return "0%";
  }
}