class Reporte {
  final String conductorId;
  final int semanaId;
  final DateTime fecha;
  final String placa;
  final String conductor;

  final int viajes;
  final double distance;
  final double efectivo;
  final double noEfectivo;
  final double gnv;
  final double gasolina;
  final double combustible;
  final double costoLavado;
  final double costoOtro;
  final double costoTotal;
  final double gananciaConductorEfectivo;
  final double gananciaConductorNoEfectivo;
  final double gananciaConductorTotal;
  final double totalADepositar;
  final double depositado;
  final double debt;

  Reporte({
    required this.conductorId,
    required this.semanaId,
    required this.fecha,
    required this.placa,
    required this.conductor,
    required this.viajes,
    required this.distance,
    required this.efectivo,
    required this.noEfectivo,
    required this.gnv,
    required this.gasolina,
    required this.combustible,
    required this.costoLavado,
    required this.costoOtro,
    required this.costoTotal,
    required this.gananciaConductorEfectivo,
    required this.gananciaConductorNoEfectivo,
    required this.gananciaConductorTotal,
    required this.totalADepositar,
    required this.depositado,
    required this.debt,
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
      distance: _toDouble(json['distance_km']),
      efectivo: _toDouble(json['efectivo']),
      noEfectivo: _toDouble(json['ganancia no efectivo']),
      gnv: _toDouble(json['gasto GNV']),
      gasolina: _toDouble(json['gasto gasolina']),
      combustible: _toDouble(json['combustible']),
      costoLavado: _toDouble(json['costo_lavado']),
      costoOtro: _toDouble(json['costo_otro']),
      costoTotal: _toDouble(json['costo_total']),
      gananciaConductorEfectivo: _toDouble(json['ganancia conductor']),
      gananciaConductorNoEfectivo: _toDouble(
        json['ganancia_conductor_no_efectivo'],
      ),
      gananciaConductorTotal: _toDouble(json['ganancia_conductor_total']),
      totalADepositar: _toDouble(json['total a depositar']),
      depositado: _toDouble(json['depositado']),
      debt: _toDouble(json['debt']),
    );
  }
}
