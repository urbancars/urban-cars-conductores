import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../utils/formatters.dart';

class BalancePage extends StatelessWidget {
  final List<dynamic> balances;

  const BalancePage({super.key, this.balances = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Balance")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: balances.length,
        itemBuilder: (context, index) {
          final balance = balances[index];
          final conductorId = balance['conductor_id']?.toString() ?? "—";
          final semanaId = balance['semana_id']?.toString() ?? "—";
          final total = formatCurrency(balance['total']);

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("👤 Conductor: $conductorId"),
              subtitle: Text("📆 Semana: $semanaId"),
              trailing: Text(
                total,
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