import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/reporte_semanal/reporte_semanal_bloc.dart';
import '../../bloc/reporte_semanal/reporte_semanal_event.dart';
import '../../bloc/reporte_semanal/reporte_semanal_state.dart';
import '../../data/repositories/reporte_semanal_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';
import '../utils/formatters.dart';

class ReporteSemanalPage extends StatelessWidget {
  const ReporteSemanalPage({super.key});

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
          create: (_) => ReporteSemanalBloc(
            ReporteSemanalRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchReporteSemanal(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("📊 Reporte Semanal")),
            body: BlocBuilder<ReporteSemanalBloc, ReporteSemanalState>(
              builder: (context, state) {
                if (state is ReporteSemanalLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReporteSemanalLoaded) {
                  if (state.reportes.isEmpty) {
                    return const Center(child: Text("No hay reportes semanales."));
                  }
                  return ListView.builder(
                    itemCount: state.reportes.length,
                    itemBuilder: (context, index) {
                      final r = state.reportes[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: ListTile(
                          leading: const Text("📅"),
                          title: Text("Semana ${r.semanaId}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("💵 Efectivo: ${formatCurrency(r.efectivo)}"),
                              Text("💳 No efectivo: ${formatCurrency(r.noEfectivo)}"),
                              Text("⛽ Combustible: ${formatCurrency(r.combustible)}"),
                              Text("⚠️ Deuda: ${formatCurrency(r.deuda)}"),
                              Text("🎯 Bono: ${formatCurrency(r.bonoSemanal)}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ReporteSemanalError) {
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