import 'package:flutter/material.dart';
import '../../data/models/reporte_semanal.dart';
import '../utils/formatters.dart';

class ReporteSemanalDetailPage extends StatelessWidget {
  final ReporteSemanal reporte;

  const ReporteSemanalDetailPage({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semana ${reporte.semanaId}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildRow("👤 Conductor", reporte.conductorId),
          _buildRow("💵 Efectivo", formatCurrency(reporte.efectivo)),
          _buildRow("💳 No efectivo", formatCurrency(reporte.noEfectivo)),
          _buildRow("📈 Ganancias diarias", formatCurrency(reporte.gananciasDiarias)),
          _buildRow("⛽ Combustible", formatCurrency(reporte.combustible)),
          _buildRow("🏦 Depósitos calculados", formatCurrency(reporte.depositosCalculados)),
          _buildRow("💰 Depósitos realizados", formatCurrency(reporte.depositosRealizados)),
          _buildRow("⚠️ Deuda", formatCurrency(reporte.deuda)),
          _buildRow("🎯 Bono semanal", formatCurrency(reporte.bonoSemanal)),
          _buildRow("💳 Ganancia no efectivo a pagar", formatCurrency(reporte.gananciaNoEfectivoAPagar)),
          _buildRow("📊 Pago calculado", formatCurrency(reporte.pagoCalculado)),
          _buildRow("✅ Pago realizado", formatCurrency(reporte.pagoRealizado)),
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