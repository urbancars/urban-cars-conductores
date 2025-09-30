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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReporteSemanalDetailPage(reporte: reporte),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1. Week text
              Text(
                reporte.weekText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// 2. Ganancia conductor sin bono
              Text(
                "💵 Ganancia sin bono: ${formatCurrency(reporte.gananciaConductorTotalSinBono)}",
              ),

              /// 3. Bono semanal bruto + porcentaje
              Text(
                "🎯 Bono semanal: ${formatCurrency(reporte.bonoSemanalBruto)} "
                "(${(reporte.bonoSemanalPercentageFact * 100).toStringAsFixed(0)}%)",
              ),

              /// 4. Ganancia conductor total con bono
              Text(
                "✅ Total con bono: ${formatCurrency(reporte.gananciaConductorTotalConBono)}",
              ),

              /// 5. Deuda
              Text("⚠️ Deuda: ${formatCurrency(reporte.debt)}"),

              /// 6. Pago calculado
              Text(
                "💳 Pago calculado: ${formatCurrency(reporte.pagoCalculado)}",
              ),

              /// 7. Pago realizado
              Text(
                "📥 Pago realizado: ${formatCurrency(reporte.pagoRealizado)}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
