import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/balance/balance_bloc.dart';
import '../../bloc/balance/balance_event.dart';
import '../../bloc/balance/balance_state.dart';
import '../../data/repositories/balance_repository.dart';
import '../../data/services/api_service.dart';
import '../../ui/utils/formatters.dart';
import '../../config.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/widgets/refreshable_bloc_page.dart'; // ✅ added

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  Future<String?> _getDriverId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('driverId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getDriverId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text("⚠️ No driver ID found")),
          );
        }

        final driverId = snapshot.data!;

        return BlocProvider(
          create: (_) => BalanceBloc(
            BalanceRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchBalance(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Balance")),
            drawer: AppDrawer(),
            body: BlocBuilder<BalanceBloc, BalanceState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    ctx.read<BalanceBloc>().add(
                      FetchBalance(driverId: driverId),
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
                              subtitle: Text("Conductor: ${b.conductorId}"),
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
