import '../models/reporte.dart';
import '../services/api_service.dart';

class ReportesRepository {
  final ApiService api;

  ReportesRepository(this.api);

  Future<List<Reporte>> fetchReportes(int driverId, {int days = 14}) async {
    final list = await api.getReportes(driverId.toString(), days: days);
    return list.map((e) => Reporte.fromJson(e)).toList();
  }
}