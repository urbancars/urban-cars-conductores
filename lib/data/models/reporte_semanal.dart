class ReporteSemanal {
  final String semanaId;
  final String conductorId;
  final double efectivo;
  final double noEfectivo;
  final double gananciaTotal;
  final double gananciaConductorEfectivo;
  final double gananciaConductorNoEfectivo;
  final double gananciaConductorTotalSinBono;
  final double gastoGnv;
  final double gastoGasolina;
  final double combustible;
  final double depositosCalculados;
  final double depositosRealizados;
  final double debt;
  final double costoLavado;
  final double costoOtro;
  final double costoTotal;
  final double ridesTotal;
  final double distanceKmTotal;
  final double bonoSemanalNeto;
  final double bonoSemanalBruto;
  final double bonoSemanalPercentageFact;
  final double gananciaConductorTotalConBono;
  final double pagoCalculado;
  final double pagoRealizado;
  final String weekText;

  ReporteSemanal({
    required this.semanaId,
    required this.conductorId,
    required this.efectivo,
    required this.noEfectivo,
    required this.gananciaTotal,
    required this.gananciaConductorEfectivo,
    required this.gananciaConductorNoEfectivo,
    required this.gananciaConductorTotalSinBono,
    required this.gastoGnv,
    required this.gastoGasolina,
    required this.combustible,
    required this.depositosCalculados,
    required this.depositosRealizados,
    required this.debt,
    required this.costoLavado,
    required this.costoOtro,
    required this.costoTotal,
    required this.ridesTotal,
    required this.distanceKmTotal,
    required this.bonoSemanalNeto,
    required this.bonoSemanalBruto,
    required this.bonoSemanalPercentageFact,
    required this.gananciaConductorTotalConBono,
    required this.pagoCalculado,
    required this.pagoRealizado,
    required this.weekText,
  });

  factory ReporteSemanal.fromJson(Map<String, dynamic> json) {
    return ReporteSemanal(
      semanaId: json['semana_id'].toString(),
      conductorId: json['conductor_id'].toString(),
      efectivo: double.tryParse(json['efectivo'].toString()) ?? 0.0,
      noEfectivo: double.tryParse(json['no_efectivo'].toString()) ?? 0.0,
      gananciaTotal: double.tryParse(json['ganancia_total'].toString()) ?? 0.0,
      gananciaConductorEfectivo:
          double.tryParse(json['ganancia_conductor_efectivo'].toString()) ??
          0.0,
      gananciaConductorNoEfectivo:
          double.tryParse(json['ganancia_conductor_no_efectivo'].toString()) ??
          0.0,
      gananciaConductorTotalSinBono:
          double.tryParse(
            json['ganancia_conductor_total_sin_bono'].toString(),
          ) ??
          0.0,
      gastoGnv: double.tryParse(json['gasto_gnv'].toString()) ?? 0.0,
      gastoGasolina: double.tryParse(json['gasto_gasolina'].toString()) ?? 0.0,
      combustible: double.tryParse(json['combustible'].toString()) ?? 0.0,
      depositosCalculados:
          double.tryParse(json['depositos_calculados'].toString()) ?? 0.0,
      depositosRealizados:
          double.tryParse(json['depositos_realizados'].toString()) ?? 0.0,
      debt: double.tryParse(json['debt'].toString()) ?? 0.0,
      costoLavado: double.tryParse(json['costo_lavado'].toString()) ?? 0.0,
      costoOtro: double.tryParse(json['costo_otro'].toString()) ?? 0.0,
      costoTotal: double.tryParse(json['costo_total'].toString()) ?? 0.0,
      ridesTotal: double.tryParse(json['rides_total'].toString()) ?? 0.0,
      distanceKmTotal:
          double.tryParse(json['distance_km_total'].toString()) ?? 0.0,
      bonoSemanalNeto:
          double.tryParse(json['bono_semanal_neto'].toString()) ?? 0.0,
      bonoSemanalBruto:
          double.tryParse(json['bono_semanal_bruto'].toString()) ?? 0.0,
      bonoSemanalPercentageFact:
          double.tryParse(json['bono_semanal_percentage_fact'].toString()) ??
          0.0,
      gananciaConductorTotalConBono:
          double.tryParse(
            json['ganancia_conductor_total_con_bono'].toString(),
          ) ??
          0.0,
      pagoCalculado: double.tryParse(json['pago_calculado'].toString()) ?? 0.0,
      pagoRealizado: double.tryParse(json['pago_realizado'].toString()) ?? 0.0,
      weekText: json['week_text'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'semana_id': semanaId,
      'conductor_id': conductorId,
      'efectivo': efectivo,
      'no_efectivo': noEfectivo,
      'ganancia_conducto_efectivo': gananciaConductorEfectivo,
      'ganancia_conductor_no_efectivo': gananciaConductorNoEfectivo,
      'ganancia_conductor_total_sin_bono': gananciaConductorTotalSinBono,
      'gasto_gnv': gastoGnv,
      'gasto_gasolina': gastoGasolina,
      'combustible': combustible,
      'depositos_calculados': depositosCalculados,
      'depositos_realizados': depositosRealizados,
      'debt': debt,
      'costo_lavado': costoLavado,
      'costo_otro': costoOtro,
      'costo_total': costoTotal,
      'rides_total': ridesTotal,
      'distance_km_total': distanceKmTotal,
      'bono_semanal_neto': bonoSemanalNeto,
      'bono_semanal_bruto': bonoSemanalBruto,
      'bono_semanal_percentage_fact': bonoSemanalPercentageFact,
      'ganancia_conductor_total_con_bono': gananciaConductorTotalConBono,
      'pago_calculado': pagoCalculado,
      'pago_realizado': pagoRealizado,
      'week_text': weekText,
    };
  }
}
