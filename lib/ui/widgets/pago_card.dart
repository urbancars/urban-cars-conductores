import 'package:flutter/material.dart';

import '../../ui/utils/formatters.dart';
import '../../data/models/pago.dart';

class PagoCard extends StatelessWidget {
  final Pago pago;

  const PagoCard({super.key, required this.pago});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Text("💰"),
        title: Text("${pago.conductor} — ${formatCurrency(pago.monto)}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha: ${formatDate(pago.fecha)}"),
            Text("Semana ID: ${pago.semanaId}"),
            Text("Hasta: ${formatDate(pago.endOfCorrespondingWeek)}"),
          ],
        ),
      ),
    );
  }
}
