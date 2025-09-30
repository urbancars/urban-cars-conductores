import '../models/goal_bonus.dart';
import '../services/api_service.dart';

class GoalBonusRepository {
  final ApiService api;

  // 🔹 In-memory cache
  List<GoalBonus>? _cachedBonuses;
  DateTime? _lastFetchTime;

  GoalBonusRepository(this.api);

  Future<List<GoalBonus>> fetchGoalBonus(
    String driverId, {
    bool forceRefresh = false,
  }) async {
    // ✅ Return cache if available and not forced
    if (!forceRefresh && _cachedBonuses != null) {
      //print("⚡ Returning goal_bonus from cache");
      return _cachedBonuses!;
    }

    //print("🌐 Fetching goal_bonus from API...");

    try {
      final list = await api.getGoalBonus(driverId);

      final parsed = list.map((e) {
        try {
          return GoalBonus.fromJson(e);
        } catch (err) {
          throw Exception("Error al parsear un bonus: $e");
        }
      }).toList();

      // ✅ Save in cache
      _cachedBonuses = parsed;
      _lastFetchTime = DateTime.now();

      return parsed;
    } catch (e) {
      throw Exception("No se pudieron cargar los bonos: $e");
    }
  }

  /// Optional: clear cache (e.g. after logout)
  void clearCache() {
    _cachedBonuses = null;
    _lastFetchTime = null;
  }
}
