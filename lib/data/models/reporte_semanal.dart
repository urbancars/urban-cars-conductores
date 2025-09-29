class ReporteSemanal {
  final String conductorId;
  final int semanaId;
  final double efectivo;
  final double noEfectivo;
  final double gananciasDiarias;
  final double combustible;
  final double depositosCalculados;
  final double depositosRealizados;
  final double deuda;
  final double bonoSemanal;
  final double gananciaNoEfectivoAPagar;
  final double pagoCalculado;
  final double pagoRealizado;

  ReporteSemanal({
    required this.conductorId,
    required this.semanaId,
    required this.efectivo,
    required this.noEfectivo,
    required this.gananciasDiarias,
    required this.combustible,
    required this.depositosCalculados,
    required this.depositosRealizados,
    required this.deuda,
    required this.bonoSemanal,
    required this.gananciaNoEfectivoAPagar,
    required this.pagoCalculado,
    required this.pagoRealizado,
  });

  factory ReporteSemanal.fromJson(Map<String, dynamic> json) {
    return ReporteSemanal(
      conductorId: json['conductor_id'].toString(),
      semanaId: int.tryParse(json['semana_id'].toString()) ?? 0,
      efectivo: double.tryParse(json['efectivo'].toString()) ?? 0.0,
      noEfectivo: double.tryParse(json['no_efectivo'].toString()) ?? 0.0,
      gananciasDiarias: double.tryParse(json['ganancias_diarias'].toString()) ?? 0.0,
      combustible: double.tryParse(json['combustible'].toString()) ?? 0.0,
      depositosCalculados: double.tryParse(json['depositos_calculados'].toString()) ?? 0.0,
      depositosRealizados: double.tryParse(json['depositos_realizados'].toString()) ?? 0.0,
      deuda: double.tryParse(json['deuda'].toString()) ?? 0.0,
      bonoSemanal: double.tryParse(json['bono_semanal'].toString()) ?? 0.0,
      gananciaNoEfectivoAPagar: double.tryParse(json['ganancia_no_efectivo_a_pagar'].toString()) ?? 0.0,
      pagoCalculado: double.tryParse(json['pago_calculado'].toString()) ?? 0.0,
      pagoRealizado: double.tryParse(json['pago_realizado'].toString()) ?? 0.0,
    );
  }
}