import '../models/pago.dart';
import '../services/api_service.dart';

class PagosRepository {
  final ApiService api;

  // 🔹 In-memory cache
  List<Pago>? _cachedPagos;
  DateTime? _lastFetchTime;

  PagosRepository(this.api);

  Future<List<Pago>> fetchPagos(
    String driverId, {
    bool forceRefresh = false,
  }) async {
    // ✅ If we have cache and not forced, return it
    if (!forceRefresh && _cachedPagos != null) {
      //print("⚡ Returning pagos from cache");
      return _cachedPagos!;
    }

    //print("🌐 Fetching pagos from API...");

    try {
      final list = await api.getPagos(driverId);

      final parsed = list.map((e) {
        try {
          return Pago.fromJson(e);
        } catch (err) {
          throw Exception("Error al parsear un pago: $e");
        }
      }).toList();

      // ✅ Save in cache
      _cachedPagos = parsed;
      _lastFetchTime = DateTime.now();

      return parsed;
    } catch (e) {
      throw Exception("No se pudieron cargar los pagos: $e");
    }
  }

  /// Optional: clear cache (e.g. after logout)
  void clearCache() {
    _cachedPagos = null;
    _lastFetchTime = null;
  }
}
