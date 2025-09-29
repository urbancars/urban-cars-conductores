import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/reporte_semanal/reporte_semanal_bloc.dart';
import '../../bloc/reporte_semanal/reporte_semanal_event.dart';
import '../../bloc/reporte_semanal/reporte_semanal_state.dart';
import '../../data/repositories/reporte_semanal_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/utils/formatters.dart';
import 'reporte_semanal_detail_page.dart';

class ReporteSemanalPage extends StatelessWidget {
  final int driverId;
  const ReporteSemanalPage({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReporteSemanalBloc(
        ReporteSemanalRepository(ApiService(baseUrl: AppConfig.apiUrl)),
      )..add(FetchReporteSemanal(driverId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("📊 Reporte Semanal")),
        drawer: const AppDrawer(),
        body: BlocBuilder<ReporteSemanalBloc, ReporteSemanalState>(
          builder: (context, state) {
            if (state is ReporteSemanalLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReporteSemanalLoaded) {
              if (state.reportes.isEmpty) {
                return const Center(child: Text("No hay reportes semanales"));
              }
              return ListView.builder(
                itemCount: state.reportes.length,
                itemBuilder: (_, i) {
                  final reporte = state.reportes[i];
                  return Card(
                    child: ListTile(
                      title: Text("Semana ${reporte.semanaId}"),
                      subtitle: Text("Conductor: ${reporte.conductorId}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReporteSemanalDetailPage(reporte: reporte),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is ReporteSemanalError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}