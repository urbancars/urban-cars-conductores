import '../models/reporte.dart';
import '../services/api_service.dart';

class ReportesRepository {
  final ApiService api;

  // 🔹 In-memory cache
  List<Reporte>? _cachedReportes;
  DateTime? _lastFetchTime;

  ReportesRepository(this.api);

  Future<List<Reporte>> fetchReportes(
    String driverId, {
    bool forceRefresh = false,
  }) async {
    // ✅ Return cache unless forced
    if (!forceRefresh && _cachedReportes != null) {
      //print("⚡ Returning reportes from cache");
      return _cachedReportes!;
    }

    //print("🌐 Fetching reportes from API...");

    final list = await api.getReportes(driverId);
    final parsed = list.map((e) => Reporte.fromJson(e)).toList();

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
