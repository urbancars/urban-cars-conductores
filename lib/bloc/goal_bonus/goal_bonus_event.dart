abstract class GoalBonusEvent {}

class FetchGoalBonus extends GoalBonusEvent {
  final int driverId;
  FetchGoalBonus(this.driverId);
}