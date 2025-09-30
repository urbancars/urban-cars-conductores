import 'package:flutter/material.dart';
import '../../data/models/goal_bonus.dart';
import '../utils/formatters.dart';

class GoalBonusCard extends StatelessWidget {
  final GoalBonus bonus;

  const GoalBonusCard({super.key, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Semana: ${bonus.weekText}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Monto: ${formatCurrency(bonus.monto)}"),
            Text("Porcentaje: ${formatPercentage(bonus.porcentaje)}"),
            Text(
              "Monto Conductor: ${formatCurrency(bonus.montoConductor)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
