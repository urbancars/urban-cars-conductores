import 'package:flutter/material.dart';
import '../../data/models/reporte.dart';
import '../utils/formatters.dart';

class ReporteDetailPage extends StatelessWidget {
  final Reporte reporte;

  const ReporteDetailPage({super.key, required this.reporte});

  /// Row for individual values
  Widget _buildRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// Block grouping multiple rows + optional info popup
  Widget _buildBlock({
    required String title,
    required List<Widget> children,
    IconData? infoIcon,
    String? infoText,
    required BuildContext context,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (infoIcon != null && infoText != null)
                  IconButton(
                    icon: Icon(infoIcon, size: 18, color: Colors.grey.shade600),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(title),
                          content: Text(infoText),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte diario — ${formatDateWithWeekday(reporte.fecha)}"),
      ),
      body: ListView(
        children: [
          // ℹ️ Información block
          _buildBlock(
            title: "ℹ️ Información",
            context: context,
            children: [
              _buildRow("Auto", reporte.placa),
              _buildRow("Viajes", reporte.viajes.toString()),
              _buildRow("Distancia", formatDistance(reporte.distance)),
            ],
          ),

          // 💰 Ganancia conductor (grouped)
          _buildBlock(
            title: "👨‍✈️ Ganancia conductor",
            context: context,
            infoIcon: Icons.help_outline,
            infoText: """
- El 30% del efectivo el conductor lo deja para sí mismo cada día.
- El 30% del no efectivo se paga por los días de lunes a domingo el miércoles de la semana siguiente (junto con el bono semanal).
            """,
            children: [
              _buildRow(
                "Efectivo",
                formatCurrency(reporte.gananciaConductorEfectivo),
              ),
              _buildRow(
                "No efectivo",
                formatCurrency(reporte.gananciaConductorNoEfectivo),
              ),
              _buildRow(
                "TOTAL",
                formatCurrency(reporte.gananciaConductorTotal),
                bold: true,
              ),
            ],
          ),

          // ⛽ Combustible (grouped)
          _buildBlock(
            title: "⛽ Combustible",
            context: context,
            infoIcon: Icons.help_outline,
            infoText: """
- Se pagan 5 soles por cada día de trabajo al conductor para mantener el nivel mínimo de gasolina.
- El GNV se compensa según la distancia total más un margen adicional del 35% (para trayectos vacíos) y con un costo de 16 soles por cada 100 km.
            """,
            children: [
              _buildRow("GNV", formatCurrency(reporte.gnv)),
              _buildRow("Gasolina", formatCurrency(reporte.gasolina)),
              _buildRow(
                "TOTAL",
                formatCurrency(reporte.combustible),
                bold: true,
              ),
            ],
          ),
          // 🔹 NEW: Lavado y otros gastos
          _buildBlock(
            title: "🧼 Lavado y otros gastos",
            context: context,
            infoIcon: Icons.help_outline,
            infoText: """
Estos costos no se descuentan del monto a depositar cada día, sino que se devuelven junto con otros pagos de lun-dom el miércoles siguiente.
              """,
            children: [
              _buildRow("Lavado", formatCurrency(reporte.costoLavado)),
              _buildRow(
                "Otros costos por compensar",
                formatCurrency(reporte.costoOtro),
              ),
              _buildRow(
                "TOTAL",
                formatCurrency(reporte.costoTotal),
                bold: true,
              ),
            ],
          ),

          // 🏦 Depósitos y deuda (grouped)
          _buildBlock(
            title: "🏦 Depósitos",
            context: context,
            infoIcon: Icons.help_outline,
            infoText: """
- Debe depositar el 70% de los ingresos diarios en efectivo, menos el costo de combustible calculado automáticamente.
- Gastos como lavados se compensan por los días de lunes a domingo el miércoles siguiente, junto con ingresos no efectivos y el bono semanal.
- Los depósitos deben hacerse completos y puntuales; de lo contrario, se cancelarán los bonos y, en casos graves, se dará por terminado el contrato y se retirará el vehículo.
            """,
            children: [
              _buildRow(
                "Total a Depositar",
                formatCurrency(reporte.totalADepositar),
              ),
              _buildRow("Depositado", formatCurrency(reporte.depositado)),
              _buildRow("⚠️ Deuda", formatCurrency(reporte.debt), bold: true),
            ],
          ),
        ],
      ),
    );
  }
}
