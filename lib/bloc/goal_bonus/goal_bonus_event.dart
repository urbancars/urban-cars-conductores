import 'package:equatable/equatable.dart';

abstract class GoalBonusEvent extends Equatable {
  const GoalBonusEvent();

  @override
  List<Object?> get props => [];
}

class FetchGoalBonus extends GoalBonusEvent {
  final String driverId;
  final bool forceRefresh; // ✅ new

  const FetchGoalBonus({
    required this.driverId,
    this.forceRefresh = false, // ✅ default to false
  });

  @override
  List<Object?> get props => [driverId, forceRefresh];
}
