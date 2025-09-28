import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../utils/formatters.dart';

class PagosPage extends StatelessWidget {
  final List<dynamic> pagos;

  const PagosPage({super.key, this.pagos = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagos")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: pagos.length,
        itemBuilder: (context, index) {
          final pago = pagos[index];
          final conductorId = pago['conductor_id']?.toString() ?? "—";
          final fecha = pago['fecha']?.toString() ?? "—";
          final monto = formatCurrency(pago['monto']);

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("👤 Conductor: $conductorId"),
              subtitle: Text("📅 Fecha: $fecha"),
              trailing: Text(
                monto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}