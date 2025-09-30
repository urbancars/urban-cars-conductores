import '../models/reporte_semanal.dart';
import '../services/api_service.dart';

class ReporteSemanalRepository {
  final ApiService api;

  // 🔹 In-memory cache
  List<ReporteSemanal>? _cachedReportes;
  DateTime? _lastFetchTime;

  ReporteSemanalRepository(this.api);

  Future<List<ReporteSemanal>> fetchReporteSemanal(
    String driverId, {
    bool forceRefresh = false,
  }) async {
    // ✅ Return cache unless forced
    if (!forceRefresh && _cachedReportes != null) {
      //print("⚡ Returning reporte_semanal from cache");
      return _cachedReportes!;
    }

    //print("🌐 Fetching reporte_semanal from API...");

    final list = await api.getReporteSemanal(driverId);
    final parsed = list.map((e) => ReporteSemanal.fromJson(e)).toList();

    // ✅ Save in cache
    _cachedReportes = parsed;
    _lastFetchTime = DateTime.now();

    return parsed;
  }

  /// Optional: clear cache (e.g. after logout)
  void clearCache() {
    _cachedReportes = null;
    _lastFetchTime = null;
  }
}
