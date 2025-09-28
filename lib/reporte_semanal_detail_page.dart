import 'package:flutter/material.dart';
import 'utils.dart';

class ReporteSemanalDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ReporteSemanalDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semana ${data['semana_id']}")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildRow("Efectivo", formatMoney(data['efectivo'])),
          buildRow("No Efectivo", formatMoney(data['no_efectivo'])),
          buildRow("Ganancias Diarias", formatMoney(data['ganancias_diarias'])),
          buildRow("Combustible", formatMoney(data['combustible'])),
          buildRow("Depósitos Calculados", formatMoney(data['depositos_calculados'])),
          buildRow("Depósitos Realizados", formatMoney(data['depositos_realizados'])),
          buildRow("Deuda", formatMoney(data['deuda'])),
          buildRow("Bono Semanal", formatMoney(data['bono_semanal'])),
          buildRow("Ganancia No Efectivo a Pagar", formatMoney(data['ganancia_no_efectivo_a_pagar'])),
          buildRow("Pago Calculado", formatMoney(data['pago_calculado'])),
          buildRow("Pago Realizado", formatMoney(data['pago_realizado'])),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}