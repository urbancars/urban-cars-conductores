import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/pagos/pagos_bloc.dart';
import '../../bloc/pagos/pagos_event.dart';
import '../../bloc/pagos/pagos_state.dart';
import '../../data/repositories/pagos_repository.dart';
import '../../ui/widgets/pago_card.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/widgets/refreshable_bloc_page.dart';
import '../../ui/widgets/driver_guard.dart';

class PagosPage extends StatelessWidget {
  const PagosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverGuard(
      builder: (context, driverId) {
        return BlocProvider(
          create: (_) =>
              PagosBloc(context.read<PagosRepository>()) // ✅ use global repo
                ..add(FetchPagos(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Pagos")),
            drawer: const AppDrawer(),
            body: BlocBuilder<PagosBloc, PagosState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    // ✅ Pull-to-refresh bypasses cache
                    ctx.read<PagosBloc>().add(
                      FetchPagos(driverId: driverId, forceRefresh: true),
                    );
                  },
                  builder: (ctx) {
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
                          return PagoCard(pago: pago);
                        },
                      );
                    } else if (state is PagosError) {
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
