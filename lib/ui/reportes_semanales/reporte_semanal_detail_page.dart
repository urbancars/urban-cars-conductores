import 'package:flutter/material.dart';
import '../utils/formatters.dart';

class ReporteSemanalDetailPage extends StatelessWidget {
  final Map<String, dynamic> reporte;

  const ReporteSemanalDetailPage({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semana ${reporte['semana_id'] ?? '—'}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildRow("👤 Conductor", reporte['conductor_id']?.toString()),
          _buildRow("💵 Efectivo", formatCurrency(reporte['efectivo'])),
          _buildRow("💳 No efectivo", formatCurrency(reporte['no_efectivo'])),
          _buildRow("📈 Ganancias diarias", formatCurrency(reporte['ganancias_diarias'])),
          _buildRow("⛽ Combustible", formatCurrency(reporte['combustible'])),
          _buildRow("🏦 Depósitos calculados", formatCurrency(reporte['depositos_calculados'])),
          _buildRow("💰 Depósitos realizados", formatCurrency(reporte['depositos_realizados'])),
          _buildRow("⚠️ Deuda", formatCurrency(reporte['deuda'])),
          _buildRow("🎯 Bono semanal", formatCurrency(reporte['bono_semanal'])),
          _buildRow("💳 Ganancia no efectivo a pagar", formatCurrency(reporte['ganancia_no_efectivo_a_pagar'])),
          _buildRow("📊 Pago calculado", formatCurrency(reporte['pago_calculado'])),
          _buildRow("✅ Pago realizado", formatCurrency(reporte['pago_realizado'])),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value ?? "—",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}