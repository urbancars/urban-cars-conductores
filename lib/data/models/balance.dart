class Balance {
  final String conductorId;
  final double monto;

  Balance({
    required this.conductorId,
    required this.monto,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      conductorId: json['conductor_id'].toString(),
      monto: double.tryParse(json['balance'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conductor_id': conductorId,
      'balance': monto,
    };
  }
}