import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/balance/balance_bloc.dart';
import '../../bloc/balance/balance_event.dart';
import '../../bloc/balance/balance_state.dart';
import '../../data/repositories/balance_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/utils/formatters.dart';

class BalancePage extends StatelessWidget {
  final int driverId;
  const BalancePage({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BalanceBloc(
        BalanceRepository(ApiService(baseUrl: AppConfig.apiUrl)),
      )..add(FetchBalance(driverId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("📊 Balance")),
        drawer: const AppDrawer(),
        body: BlocBuilder<BalanceBloc, BalanceState>(
          builder: (context, state) {
            if (state is BalanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BalanceLoaded) {
              if (state.balances.isEmpty) {
                return const Center(child: Text("No hay balance disponible"));
              }
              return ListView.builder(
                itemCount: state.balances.length,
                itemBuilder: (_, i) {
                  final b = state.balances[i];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet),
                      title: Text("Conductor ID: ${b.conductorId}"),
                      subtitle: Text("Balance: ${formatCurrency(b.balance)}"),
                    ),
                  );
                },
              );
            } else if (state is BalanceError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}