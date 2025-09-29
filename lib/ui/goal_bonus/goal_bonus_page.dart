import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/goal_bonus/goal_bonus_bloc.dart';
import '../../bloc/goal_bonus/goal_bonus_event.dart';
import '../../bloc/goal_bonus/goal_bonus_state.dart';
import '../../data/repositories/goal_bonus_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/utils/formatters.dart';

class GoalBonusPage extends StatelessWidget {
  final int driverId;
  const GoalBonusPage({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoalBonusBloc(
        GoalBonusRepository(ApiService(baseUrl: AppConfig.apiUrl)),
      )..add(FetchGoalBonus(driverId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("🎯 Goal Bonus")),
        drawer: const AppDrawer(),
        body: BlocBuilder<GoalBonusBloc, GoalBonusState>(
          builder: (context, state) {
            if (state is GoalBonusLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GoalBonusLoaded) {
              if (state.bonuses.isEmpty) {
                return const Center(child: Text("No hay bonos disponibles"));
              }
              return ListView.builder(
                itemCount: state.bonuses.length,
                itemBuilder: (_, i) {
                  final bonus = state.bonuses[i];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(Icons.star),
                      title: Text("Conductor: ${bonus.conductorId}"),
                      subtitle: Text(
                        "Monto: ${formatCurrency(bonus.monto)}\n"
                        "Porcentaje: ${bonus.porcentaje}%",
                      ),
                    ),
                  );
                },
              );
            } else if (state is GoalBonusError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}