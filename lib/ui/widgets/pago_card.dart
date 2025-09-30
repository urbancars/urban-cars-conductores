import 'package:flutter/material.dart';
import '../../ui/utils/formatters.dart';
import '../../data/models/pago.dart';

class PagoCard extends StatelessWidget {
  final Pago pago;

  const PagoCard({super.key, required this.pago});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Text("💰", style: TextStyle(fontSize: 20)),
        // 🔹 Smaller fecha row
        title: Text(
          "Fecha de pago: ${formatDateWithWeekday(pago.fecha)}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        // 🔹 Bigger monto row
        subtitle: Text(
          "Monto: ${formatCurrency(pago.monto)}",
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
