class GoalBonus {
  final String conductorId;
  final String semana;
  final double monto;
  final double porcentaje;
  final double montoConductor;
  final String weekText;

  GoalBonus({
    required this.conductorId,
    required this.semana,
    required this.monto,
    required this.porcentaje,
    required this.montoConductor,
    required this.weekText,
  });

  factory GoalBonus.fromJson(Map<String, dynamic> json) {
    return GoalBonus(
      conductorId: json['conductor_id']?.toString() ?? '',
      semana: json['semana']?.toString() ?? '-', // 🔹 column "semana"
      monto: double.tryParse(json['monto']?.toString() ?? '0') ?? 0.0,
      porcentaje: double.tryParse(json['porcentaje']?.toString() ?? '0') ?? 0.0,
      montoConductor:
          double.tryParse(json['monto_conductor']?.toString() ?? '0') ?? 0.0,
      weekText: json['week_text']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conductor_id': conductorId,
      'semana': semana,
      'monto': monto,
      'porcentaje': porcentaje,
    };
  }
}
