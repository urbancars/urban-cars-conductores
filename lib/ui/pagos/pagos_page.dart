import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/pagos/pagos_bloc.dart';
import '../../bloc/pagos/pagos_event.dart';
import '../../bloc/pagos/pagos_state.dart';
import '../../data/repositories/pagos_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/utils/formatters.dart';

class PagosPage extends StatelessWidget {
  final int driverId;
  const PagosPage({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PagosBloc(
        PagosRepository(ApiService(baseUrl: AppConfig.apiUrl)),
      )..add(FetchPagos(driverId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("💳 Pagos")),
        drawer: const AppDrawer(),
        body: BlocBuilder<PagosBloc, PagosState>(
          builder: (context, state) {
            if (state is PagosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PagosLoaded) {
              if (state.pagos.isEmpty) {
                return const Center(child: Text("No hay pagos disponibles"));
              }
              return ListView.builder(
                itemCount: state.pagos.length,
                itemBuilder: (_, i) {
                  final pago = state.pagos[i];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(Icons.payments),
                      title: Text("Monto: ${formatCurrency(pago.monto)}"),
                      subtitle: Text("Fecha: ${formatDate(pago.fecha)}"),
                    ),
                  );
                },
              );
            } else if (state is PagosError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
