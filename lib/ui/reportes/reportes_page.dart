import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/reportes/reportes_bloc.dart';
import '../../bloc/reportes/reportes_event.dart';
import '../../bloc/reportes/reportes_state.dart';
import '../../data/repositories/reportes_repository.dart';
import '../widgets/reporte_card.dart';
import '../widgets/app_drawer.dart';

class ReportesPage extends StatelessWidget {
final String driverId; // <- String
  const ReportesPage({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ReportesBloc(ReportesRepository())..add(LoadReportes(driverId, 14)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reportes"),
        ),
        drawer:  AppDrawer(),
        body: BlocBuilder<ReportesBloc, ReportesState>(
          builder: (context, state) {
            if (state is ReportesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportesLoaded) {
              if (state.reportes.isEmpty) {
                return const Center(child: Text("No hay reportes disponibles"));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ReportesBloc>().add(LoadReportes(driverId, 14));
                },
                child: ListView.builder(
                  itemCount: state.reportes.length,
                  itemBuilder: (context, index) {
                    final reporte = state.reportes[index];
                    return ReporteCard(reporte: reporte);
                  },
                ),
              );
            } else if (state is ReportesError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}