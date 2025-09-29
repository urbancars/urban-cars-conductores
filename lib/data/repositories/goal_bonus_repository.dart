import '../models/goal_bonus.dart';
import '../services/api_service.dart';

class GoalBonusRepository {
  final ApiService api;

  GoalBonusRepository(this.api);

  Future<List<GoalBonus>> fetchGoalBonus(String driverId) async {
    final list = await api.getGoalBonus(driverId);
    return list.map((e) => GoalBonus.fromJson(e)).toList();
  }
}