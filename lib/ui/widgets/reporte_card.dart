import 'package:flutter/material.dart';
import '../utils/formatters.dart';
import '../../data/models/reporte.dart'; // adjust import to your model

class ReporteCard extends StatelessWidget {
  final Reporte reporte;

  const ReporteCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: date + plate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateWithWeekday(reporte.fecha),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  reporte.placa ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Values list
            _buildRow("🚗 Viajes", formatNumber(reporte.viajes)),
            _buildRow("💵 Efectivo", formatCurrency(reporte.efectivo)),
            _buildRow("⛽ GNV", formatCurrency(reporte.gnv)),
            _buildRow("⛽ Gasolina", formatCurrency(reporte.gasolina)),
            _buildRow(
              "🧑‍🦱 Ganancia Conductor",
              formatCurrency(reporte.gananciaConductor),
            ),
            _buildRow("🏦 Depositar", formatCurrency(reporte.totalADepositar)),
            _buildRow("✅ Depositado", formatCurrency(reporte.depositado)),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
