class Reporte {
  final int conductorId;
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
      conductorId: int.tryParse(json['conductor_id'].toString()) ?? 0,
      fecha: DateTime.tryParse(json['fecha'].toString()) ?? DateTime.now(),
      monto: double.tryParse(json['monto'].toString()) ?? 0.0,
      viajes: int.tryParse(json['viajes'].toString()) ?? 0,
      combustible: double.tryParse(json['combustible'].toString()) ?? 0.0,
      depositos: double.tryParse(json['depositos'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conductor_id': conductorId,
      'fecha': fecha.toIso8601String(),
      'monto': monto,
      'viajes': viajes,
      'combustible': combustible,
      'depositos': depositos,
    };
  }
}