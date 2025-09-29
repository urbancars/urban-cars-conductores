import 'package:flutter/material.dart';
import 'package:reportes_app/data/models/reporte.dart';
import 'package:reportes_app/ui/utils/formatters.dart';

class ReporteCard extends StatelessWidget {
  final Reporte reporte;

  const ReporteCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: date
            Row(
              children: [
                const Text("📅 "),
                Text(
                  formatDate(reporte.fecha),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Rows
            _row("🧾 Monto", formatCurrency(reporte.monto)),
            _row("🚕 Viajes", reporte.viajes.toString()),
            _row("⛽ Combustible", formatCurrency(reporte.combustible)),
            _row("🏦 Depósitos", formatCurrency(reporte.depositos)),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}