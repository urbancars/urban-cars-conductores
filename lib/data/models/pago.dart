class Pago {
  final String conductor;
  final int conductorId;
  final double monto;
  final DateTime fecha;
  final int semanaId;
  final DateTime endOfCorrespondingWeek;

  Pago({
    required this.conductor,
    required this.conductorId,
    required this.monto,
    required this.fecha,
    required this.semanaId,
    required this.endOfCorrespondingWeek,
  });

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      conductor: json['conductor'],
      conductorId: json['conductor_id'],
      monto: (json['monto'] as num).toDouble(),
      fecha: DateTime.parse(json['fecha']),
      semanaId: json['semana_id'],
      endOfCorrespondingWeek: DateTime.parse(json['end_of_corresponding_week']),
    );
  }
}
