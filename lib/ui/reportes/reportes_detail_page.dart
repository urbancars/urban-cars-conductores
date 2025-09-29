import 'package:flutter/material.dart';
import '../../data/models/reporte.dart';
import '../../utils/formatters.dart';

class ReportesDetailPage extends StatelessWidget {
  final Reporte reporte;

  const ReportesDetailPage({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reporte del ${formatDate(reporte.fecha)}")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildRow("👤 Conductor", reporte.conductorId.toString()),
          _buildRow("📅 Fecha", formatDate(reporte.fecha)),
          _buildRow("💵 Monto", formatCurrency(reporte.monto)),
          _buildRow("📈 Viajes", reporte.viajes.toString()),
          _buildRow("⛽ Combustible", formatCurrency(reporte.combustible)),
          _buildRow("🏦 Depósitos", formatCurrency(reporte.depositos)),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}