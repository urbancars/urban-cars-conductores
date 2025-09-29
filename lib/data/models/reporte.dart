class Reporte {
  final String conductorId;
  final int semanaId;
  final DateTime fecha;
  final String placa;
  final String conductor;

  final int viajes;
  final double efectivo;
  final double noEfectivo;
  final double gnv;
  final double gasolina;
  final double gananciaConductor;
  final double totalADepositar;
  final double depositado;

  Reporte({
    required this.conductorId,
    required this.semanaId,
    required this.fecha,
    required this.placa,
    required this.conductor,
    required this.viajes,
    required this.efectivo,
    required this.noEfectivo,
    required this.gnv,
    required this.gasolina,
    required this.gananciaConductor,
    required this.totalADepositar,
    required this.depositado,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    double _toDouble(dynamic v) => double.tryParse(v?.toString() ?? "") ?? 0.0;

    int _toInt(dynamic v) => int.tryParse(v?.toString() ?? "") ?? 0;

    return Reporte(
      conductorId: json['conductor_id']?.toString() ?? "",
      semanaId: _toInt(json['semana_id']),
      fecha: DateTime.tryParse(json['fecha'].toString()) ?? DateTime.now(),
      placa: json['placa']?.toString() ?? "",
      conductor: json['conductor']?.toString() ?? "",

      viajes: _toInt(json['viajes']),
      efectivo: _toDouble(json['efectivo']),
      noEfectivo: _toDouble(json['ganancia no efectivo']),
      gnv: _toDouble(json['gasto GNV']),
      gasolina: _toDouble(json['gasto gasolina']),
      gananciaConductor: _toDouble(json['ganancia conductor']),
      totalADepositar: _toDouble(json['total a depositar']),
      depositado: _toDouble(json['depositado']),
    );
  }
}
