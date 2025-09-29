class Pago {
  final String conductorId;
  final double monto;
  final DateTime fecha;

  Pago({
    required this.conductorId,
    required this.monto,
    required this.fecha,
  });

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      conductorId: json['conductor_id'].toString(),
      monto: double.tryParse(json['monto'].toString()) ?? 0.0,
      fecha: DateTime.tryParse(json['fecha'].toString()) ?? DateTime.now(),
    );
  }
}