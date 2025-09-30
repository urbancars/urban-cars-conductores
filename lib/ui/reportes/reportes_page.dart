import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/reportes/reportes_bloc.dart';
import '../../bloc/reportes/reportes_event.dart';
import '../../bloc/reportes/reportes_state.dart';
import '../../data/repositories/reportes_repository.dart';
import '../../data/services/api_service.dart';
import '../../ui/widgets/reporte_card.dart';
import '../../ui/widgets/app_drawer.dart';
import '../../ui/widgets/refreshable_bloc_page.dart';
import '../../config.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});

  /// 🔹 Get driverId from SharedPreferences
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
          create: (_) => ReportesBloc(
            ReportesRepository(ApiService(baseUrl: AppConfig.apiUrl)),
          )..add(FetchReportes(driverId: driverId)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Reportes diarios")),
            drawer: AppDrawer(),
            body: BlocBuilder<ReportesBloc, ReportesState>(
              builder: (context, state) {
                return RefreshableBlocPage(
                  onRefresh: (ctx) async {
                    ctx.read<ReportesBloc>().add(
                      FetchReportes(driverId: driverId),
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
