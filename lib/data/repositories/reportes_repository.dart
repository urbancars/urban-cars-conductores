import '../models/reporte.dart';
import '../services/api_service.dart';

class ReportesRepository {
  final ApiService api;

  ReportesRepository(this.api);

  Future<List<Reporte>> fetchReportes(String driverId, {int days = 14}) async {
    final list = await api.getReportes(driverId, days: days);
    return list.map((e) => Reporte.fromJson(e)).toList();
  }
}