import 'package:equatable/equatable.dart';

abstract class GoalBonusEvent extends Equatable {
  const GoalBonusEvent();

  @override
  List<Object?> get props => [];
}

class FetchGoalBonus extends GoalBonusEvent {
  final String driverId;

  const FetchGoalBonus({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}