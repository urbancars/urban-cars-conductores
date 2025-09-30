import 'package:flutter/material.dart';
import '../utils/formatters.dart';
import '../../data/models/reporte.dart';
import '../reportes/reportes_detail_page.dart'; // ✅ detail page

class ReporteCard extends StatelessWidget {
  final Reporte reporte;

  const ReporteCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReporteDetailPage(reporte: reporte),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header row with darker background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDateWithWeekday(reporte.fecha),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Text("🚕", style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        "${formatNumber(reporte.viajes)} ${reporte.viajes == 1 ? 'viaje' : 'viajes'}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Regular rows
                  _buildRow("💵 Efectivo", formatCurrency(reporte.efectivo)),
                  _buildRow(
                    "⛽ Combustible",
                    formatCurrency(reporte.combustible),
                  ),
                  _buildRow(
                    "👨‍✈️ Ganancia Conductor",
                    formatCurrency(reporte.gananciaConductorEfectivo),
                  ),

                  const SizedBox(height: 12),

                  // 🔹 Depositar + Depositado (bold)
                  _buildRow(
                    "🏦 Depositar",
                    formatCurrency(reporte.totalADepositar),
                    bold: true,
                  ),
                  _buildRow(
                    "✅ Depositado",
                    formatCurrency(reporte.depositado),
                    bold: true,
                  ),

                  // 🔹 DEUDA (only if > 0)
                  if (reporte.debt > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "DEUDA",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            formatCurrency(reporte.debt),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
