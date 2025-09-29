import '../../data/models/goal_bonus.dart';

abstract class GoalBonusState {}

class GoalBonusInitial extends GoalBonusState {}
class GoalBonusLoading extends GoalBonusState {}
class GoalBonusLoaded extends GoalBonusState {
  final List<GoalBonus> bonuses;
  GoalBonusLoaded(this.bonuses);
}
class GoalBonusError extends GoalBonusState {
  final String message;
  GoalBonusError(this.message);
}