class Balance {
  final String conductorId;
  final double balance;

  Balance({
    required this.conductorId,
    required this.balance,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      conductorId: json['conductor_id'].toString(),
      balance: double.tryParse(json['balance'].toString()) ?? 0.0,
    );
  }
}