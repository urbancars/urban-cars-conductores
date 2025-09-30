import '../models/balance.dart';
import '../services/api_service.dart';

class BalanceRepository {
  final ApiService api;

  // 🔹 In-memory cache
  List<Balance>? _cachedBalance;
  DateTime? _lastFetchTime;

  BalanceRepository(this.api);

  Future<List<Balance>> fetchBalance(
    String driverId, {
    bool forceRefresh = false,
  }) async {
    // ✅ If cache exists and not forced → return cache
    if (!forceRefresh && _cachedBalance != null) {
      //print("⚡ Returning balance from cache");
      return _cachedBalance!;
    }

    //print("🌐 Fetching balance from API...");

    try {
      final list = await api.getBalance(driverId);

      final parsed = list.map((e) {
        try {
          return Balance.fromJson(e);
        } catch (err) {
          throw Exception("Error al parsear un balance: $e");
        }
      }).toList();

      // ✅ Save in cache
      _cachedBalance = parsed;
      _lastFetchTime = DateTime.now();

      return parsed;
    } catch (e) {
      throw Exception("No se pudo cargar el balance: $e");
    }
  }

  /// Clear cache (e.g. logout)
  void clearCache() {
    _cachedBalance = null;
    _lastFetchTime = null;
  }
}
