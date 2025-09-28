import 'package:flutter/material.dart';
import '../utils/formatters.dart';

class ReporteCard extends StatelessWidget {
  final Map<String, dynamic> reporte;

  const ReporteCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDate(reporte['fecha'])),
                Text(reporte['placa'] ?? ""),
              ],
            ),
            const SizedBox(height: 8),
            _buildRow("🚖 Viajes", reporte['viajes'], bold: true),
            const Divider(),
            _buildRow("💵 Efectivo", formatCurrency(reporte['efectivo'])),
            _buildRow("💳 No Efectivo", formatCurrency(reporte['ganancia no efectivo'])),
            _buildRow("⛽ GNV", formatCurrency(reporte['gasto GNV'])),
            _buildRow("⛽ Gasolina", formatCurrency(reporte['gasto gasolina'])),
            _buildRow("🧾 Ganancia Conductor", formatCurrency(reporte['ganancia conductor'])),
            _buildRow("🏦 Depositar", formatCurrency(reporte['total a depositar']), bold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, dynamic value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value?.toString() ?? "0",
            style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}