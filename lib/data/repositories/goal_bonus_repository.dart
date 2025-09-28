import '../services/api_service.dart';

class GoalBonusRepository {
  final ApiService api;

  GoalBonusRepository(this.api);

  Future<List<dynamic>> fetchGoalBonus(String driverId) async {
    return await api.fetchData('goal_bonus', driverId);
  }
}