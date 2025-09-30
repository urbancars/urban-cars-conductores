import 'package:flutter/material.dart';
import '../../data/models/reporte_semanal.dart';
import '../utils/formatters.dart';

class ReporteSemanalDetailPage extends StatelessWidget {
  final ReporteSemanal reporte;

  const ReporteSemanalDetailPage({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resumen ${reporte.weekText}")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// 1. Rendimiento
          _buildSection("📊 Rendimiento", [
            _buildRow("Viajes totales", reporte.ridesTotal.toStringAsFixed(0)),
            _buildRow(
              "Distancia total (km)",
              reporte.distanceKmTotal.toStringAsFixed(1),
            ),
          ]),

          /// 2. Ingresos totales (Efectivo + No efectivo)
          _buildSection("💵 Ingresos totales", [
            _buildRow("Efectivo", formatCurrency(reporte.efectivo)),
            _buildRow("No efectivo", formatCurrency(reporte.noEfectivo)),
            _buildRow(
              "Ingreso Total",
              formatCurrency(reporte.gananciaTotal),
              bold: true,
            ),
          ]),

          /// 3. Bonos
          _buildSection("🎯 Bonos", [
            _buildRow(
              "Bono semanal bruto",
              "${formatCurrency(reporte.bonoSemanalBruto)} "
                  "(${(reporte.bonoSemanalPercentageFact * 100).toStringAsFixed(0)}%)",
            ),
            _buildRow(
              "Bono semanal neto",
              formatCurrency(reporte.bonoSemanalNeto),
              bold: true,
            ),
          ]),

          /// 4. Ingresos del conductor
          _buildSection("👤 Ingresos del conductor", [
            _buildRow(
              "Ganancia efectivo",
              formatCurrency(reporte.gananciaConductorEfectivo),
            ),
            _buildRow(
              "Ganancia no efectivo",
              formatCurrency(reporte.gananciaConductorNoEfectivo),
            ),
            _buildRow(
              "Ganancia total sin bono",
              formatCurrency(reporte.gananciaConductorTotalSinBono),
              bold: true,
            ),
            _buildRow(
              "Ganancia total con bono",
              formatCurrency(reporte.gananciaConductorTotalConBono),
              bold: true,
            ),
          ]),

          /// 5. Costos
          _buildSection("⛽ Costos", [
            _buildRow("Gasto GNV", formatCurrency(reporte.gastoGnv)),
            _buildRow("Gasto Gasolina", formatCurrency(reporte.gastoGasolina)),
            _buildRow(
              "Combustible total",
              formatCurrency(reporte.combustible),
              bold: true,
            ),
            _buildRow("Costo lavado", formatCurrency(reporte.costoLavado)),
            _buildRow("Costo otro", formatCurrency(reporte.costoOtro)),

            _buildRow(
              "Costo total",
              formatCurrency(reporte.costoTotal),
              bold: true,
            ),
          ]),

          /// 6. Depósitos (with Deuda)
          _buildSection("🏦 Depósitos", [
            _buildRow(
              "Depósitos calculados",
              formatCurrency(reporte.depositosCalculados),
            ),
            _buildRow(
              "Depósitos realizados",
              formatCurrency(reporte.depositosRealizados),
            ),
            _buildRow("⚠️ Deuda", formatCurrency(reporte.debt), bold: true),
          ]),

          /// 7. Pagos
          _buildSection("💳 Pagos", [
            _buildRow("Pago calculado", formatCurrency(reporte.pagoCalculado)),
            _buildRow("Pago realizado", formatCurrency(reporte.pagoRealizado)),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String? value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value ?? "—",
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
