import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/reportes/reportes_bloc.dart';
import '../../bloc/reportes/reportes_event.dart';
import '../../bloc/reportes/reportes_state.dart';
import '../../data/repositories/reportes_repository.dart';
import '../../ui/widgets/reporte_card.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/widgets/refreshable_bloc_page.dart';
import '../../ui/widgets/driver_guard.dart'; // ✅
import '../../config.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverGuard(
      builder: (context, driverId) {
        return BlocProvider(
          create: (_) => ReportesBloc(
            context.read<ReportesRepository>(), // ✅ shared cached repo
          )..add(FetchReportes(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Reportes diarios")),
            drawer: const AppDrawer(),
            body: BlocBuilder<ReportesBloc, ReportesState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    // ✅ Force refresh bypasses cache
                    ctx.read<ReportesBloc>().add(
                      FetchReportes(driverId: driverId, forceRefresh: true),
                    );
                  },
                  builder: (ctx) {
                    if (state is ReportesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReportesLoaded) {
                      if (state.reportes.isEmpty) {
                        return const Center(
                          child: Text("📭 No hay reportes aún."),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.reportes.length,
                        itemBuilder: (context, index) {
                          final r = state.reportes[index];
                          return ReporteCard(reporte: r);
                        },
                      );
                    } else if (state is ReportesError) {
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
