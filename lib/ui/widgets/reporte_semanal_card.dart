import 'package:flutter/material.dart';
import '../../data/models/reporte_semanal.dart';
import '../utils/formatters.dart';
import '../../ui/reporte_semanal/reporte_semanal_detail_page.dart';

class ReporteSemanalCard extends StatelessWidget {
  final ReporteSemanal reporte;

  const ReporteSemanalCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Text("📅"),
        title: Text("Semana ${reporte.semanaId}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("💵 Efectivo: ${formatCurrency(reporte.efectivo)}"),
            Text("💳 No efectivo: ${formatCurrency(reporte.noEfectivo)}"),
            Text("⛽ Combustible: ${formatCurrency(reporte.combustible)}"),
            Text("⚠️ Deuda: ${formatCurrency(reporte.deuda)}"),
            Text("🎯 Bono: ${formatCurrency(reporte.bonoSemanal)}"),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReporteSemanalDetailPage(reporte: reporte),
            ),
          );
        },
      ),
    );
  }
}
