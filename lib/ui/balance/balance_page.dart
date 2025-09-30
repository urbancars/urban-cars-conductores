import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/balance/balance_bloc.dart';
import '../../bloc/balance/balance_event.dart';
import '../../bloc/balance/balance_state.dart';
import '../../data/repositories/balance_repository.dart';
import '../../ui/utils/formatters.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/widgets/refreshable_bloc_page.dart';
import '../../ui/widgets/driver_guard.dart'; // ✅ DriverGuard

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverGuard(
      builder: (context, driverId) {
        return BlocProvider(
          create: (_) => BalanceBloc(
            context.read<BalanceRepository>(), // ✅ use shared repo
          )..add(FetchBalance(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Balance")),
            drawer: const AppDrawer(),
            body: BlocBuilder<BalanceBloc, BalanceState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    // ✅ Force refresh bypasses cache
                    ctx.read<BalanceBloc>().add(
                      FetchBalance(driverId: driverId, forceRefresh: true),
                    );
                  },
                  builder: (ctx) {
                    if (state is BalanceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BalanceLoaded) {
                      if (state.balance.isEmpty) {
                        return const Center(
                          child: Text("No hay balances aún."),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.balance.length,
                        itemBuilder: (context, index) {
                          final b = state.balance[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            child: ListTile(
                              leading: const Text("📊"),
                              title: Text("Monto: ${formatCurrency(b.monto)}"),
                            ),
                          );
                        },
                      );
                    } else if (state is BalanceError) {
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
