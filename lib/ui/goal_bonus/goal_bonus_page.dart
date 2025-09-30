import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/goal_bonus/goal_bonus_bloc.dart';
import '../../bloc/goal_bonus/goal_bonus_event.dart';
import '../../bloc/goal_bonus/goal_bonus_state.dart';
import '../../data/repositories/goal_bonus_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../widgets/app_drawer.dart';
import '../widgets/refreshable_bloc_page.dart';
import '../widgets/driver_guard.dart'; // ✅
import '../widgets/goal_bonus_card.dart'; // ✅ new widget

class GoalBonusPage extends StatelessWidget {
  const GoalBonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverGuard(
      builder: (context, driverId) {
        return BlocProvider(
          create: (_) => GoalBonusBloc(
            GoalBonusRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchGoalBonus(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("🎯 Goal Bonus")),
            drawer: const AppDrawer(),
            body: BlocBuilder<GoalBonusBloc, GoalBonusState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    ctx.read<GoalBonusBloc>().add(
                      FetchGoalBonus(driverId: driverId),
                    );
                  },
                  builder: (ctx) {
                    if (state is GoalBonusLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GoalBonusLoaded) {
                      if (state.bonuses.isEmpty) {
                        return const Center(child: Text("No hay bonos aún."));
                      }
                      return ListView.builder(
                        itemCount: state.bonuses.length,
                        itemBuilder: (context, index) {
                          final bonus = state.bonuses[index];
                          return GoalBonusCard(bonus: bonus); // ✅ use widget
                        },
                      );
                    } else if (state is GoalBonusError) {
                      return Center(child: Text("❌ Error: ${state.message}"));
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
