class GoalBonus {
  final String conductorId;
  final String semana; // <- keep field exactly like backend column name
  final double monto;
  final double porcentaje;

  GoalBonus({
    required this.conductorId,
    required this.semana,
    required this.monto,
    required this.porcentaje,
  });

  factory GoalBonus.fromJson(Map<String, dynamic> json) {
    return GoalBonus(
      conductorId: json['conductor_id']?.toString() ?? '',
      semana: json['semana']?.toString() ?? '-', // 🔹 column "semana"
      monto: double.tryParse(json['monto']?.toString() ?? '0') ?? 0.0,
      porcentaje:
          double.tryParse(json['porcentaje']?.toString() ?? '0') ?? 0.0,
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