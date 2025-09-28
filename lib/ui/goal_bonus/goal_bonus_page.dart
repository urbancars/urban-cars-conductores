import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../utils/formatters.dart';

class GoalBonusPage extends StatelessWidget {
  final List<dynamic> bonuses;

  const GoalBonusPage({super.key, this.bonuses = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bonos Semanales")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: bonuses.length,
        itemBuilder: (context, index) {
          final bonus = bonuses[index];
          final conductorId = bonus['conductor_id']?.toString() ?? "—";
          final semanaId = bonus['semana_id']?.toString() ?? "—";
          final monto = formatCurrency(bonus['bono']);

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("👤 Conductor: $conductorId"),
              subtitle: Text("📆 Semana: $semanaId"),
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
