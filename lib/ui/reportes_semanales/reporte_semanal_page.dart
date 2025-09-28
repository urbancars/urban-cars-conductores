import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'reporte_semanal_detail_page.dart';

class ReporteSemanalPage extends StatelessWidget {
  final List<dynamic> reportes;

  const ReporteSemanalPage({super.key, this.reportes = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reportes Semanales")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: reportes.length,
        itemBuilder: (context, index) {
          final reporte = reportes[index];
          final semanaId = reporte['semana_id']?.toString() ?? "—";

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("📆 Semana $semanaId"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReporteSemanalDetailPage(
                      reporte: reporte,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}