class Reporte {
  final String conductorId;
  final DateTime fecha;
  final double monto;
  final int viajes;
  final double combustible;
  final double depositos;

  Reporte({
    required this.conductorId,
    required this.fecha,
    required this.monto,
    required this.viajes,
    required this.combustible,
    required this.depositos,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      conductorId: json['conductor_id']?.toString() ?? "",
      fecha: DateTime.tryParse(json['fecha'].toString()) ?? DateTime.now(),
      monto: double.tryParse(json['monto'].toString()) ?? 0.0,
      viajes: int.tryParse(json['viajes'].toString()) ?? 0,
      combustible: double.tryParse(json['combustible'].toString()) ?? 0.0,
      depositos: double.tryParse(json['depositos'].toString()) ?? 0.0,
    );
  }
}