import '../services/api_service.dart';

class ReportesSemanalesRepository {
  final ApiService api;

  ReportesSemanalesRepository(this.api);

  Future<List<dynamic>> fetchReportesSemanales(String driverId) async {
    return await api.fetchData('reporte_semanal', driverId);
  }
}
