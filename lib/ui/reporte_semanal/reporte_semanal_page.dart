import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/reporte_semanal/reporte_semanal_bloc.dart';
import '../../bloc/reporte_semanal/reporte_semanal_event.dart';
import '../../bloc/reporte_semanal/reporte_semanal_state.dart';
import '../../data/repositories/reporte_semanal_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../widgets/app_drawer.dart';
import '../widgets/refreshable_bloc_page.dart';
import '../widgets/reporte_semanal_card.dart';
import '../widgets/driver_guard.dart'; // ✅ added

class ReporteSemanalPage extends StatelessWidget {
  const ReporteSemanalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverGuard(
      builder: (context, driverId) {
        return BlocProvider(
          create: (_) => ReporteSemanalBloc(
            ReporteSemanalRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchReporteSemanal(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("📊 Reporte Semanal")),
            drawer: const AppDrawer(),
            body: BlocBuilder<ReporteSemanalBloc, ReporteSemanalState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    ctx.read<ReporteSemanalBloc>().add(
                      FetchReporteSemanal(driverId: driverId),
                    );
                  },
                  builder: (ctx) {
                    if (state is ReporteSemanalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReporteSemanalLoaded) {
                      if (state.reportes.isEmpty) {
                        return const Center(
                          child: Text("No hay reportes semanales."),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.reportes.length,
                        itemBuilder: (context, index) {
                          final r = state.reportes[index];
                          return ReporteSemanalCard(reporte: r);
                        },
                      );
                    } else if (state is ReporteSemanalError) {
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
