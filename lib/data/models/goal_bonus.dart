class GoalBonus {
  final String conductorId;
  final double monto;
  final int porcentaje;

  GoalBonus({
    required this.conductorId,
    required this.monto,
    required this.porcentaje,
  });

  factory GoalBonus.fromJson(Map<String, dynamic> json) {
    return GoalBonus(
      conductorId: json['conductor_id'].toString(),
      monto: double.tryParse(json['monto'].toString()) ?? 0.0,
      porcentaje: int.tryParse(json['porcentaje'].toString()) ?? 0,
    );
  }
}