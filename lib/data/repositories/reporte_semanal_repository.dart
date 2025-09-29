import '../models/reporte_semanal.dart';
import '../services/api_service.dart';

class ReporteSemanalRepository {
  final ApiService api;

  ReporteSemanalRepository(this.api);

  Future<List<ReporteSemanal>> fetchReporteSemanal(String driverId) async {
    final list = await api.getReporteSemanal(driverId);
    return list.map((e) => ReporteSemanal.fromJson(e)).toList();
  }
}