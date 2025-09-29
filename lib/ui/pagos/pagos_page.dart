import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/pagos/pagos_bloc.dart';
import '../../bloc/pagos/pagos_event.dart';
import '../../bloc/pagos/pagos_state.dart';
import '../../data/repositories/pagos_repository.dart';
import '../../data/services/api_service.dart';
import '../../ui/utils/formatters.dart';
import '../../config.dart';

class PagosPage extends StatelessWidget {
  const PagosPage({super.key});

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
          create: (_) => PagosBloc(
            PagosRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchPagos(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Pagos")),
            // 🔹 Drawer removed to keep page stateless and clean
            body: BlocBuilder<PagosBloc, PagosState>(
              builder: (context, state) {
                if (state is PagosLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PagosLoaded) {
                  if (state.pagos.isEmpty) {
                    return const Center(child: Text("No hay pagos aún."));
                  }
                  return ListView.builder(
                    itemCount: state.pagos.length,
                    itemBuilder: (context, index) {
                      final pago = state.pagos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        child: ListTile(
                          leading: const Text("💰"),
                          title: Text("Monto: ${formatCurrency(pago.monto)}"),
                          subtitle: Text("Fecha: ${formatDate(pago.fecha)}"),
                        ),
                      );
                    },
                  );
                } else if (state is PagosError) {
                  return Center(child: Text("❌ Error: ${state.message}"));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}