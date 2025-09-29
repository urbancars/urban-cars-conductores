import '../models/goal_bonus.dart';
import '../services/api_service.dart';

class GoalBonusRepository {
  final ApiService api;

  GoalBonusRepository(this.api);

  Future<List<GoalBonus>> fetchGoalBonus(int driverId) async {
    final list = await api.getGoalBonus(driverId.toString());
    return list.map((e) => GoalBonus.fromJson(e)).toList();
  }
}