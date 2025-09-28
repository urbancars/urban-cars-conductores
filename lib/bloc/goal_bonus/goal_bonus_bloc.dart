import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/goal_bonus_repository.dart';

abstract class GoalBonusEvent {}

class LoadGoalBonus extends GoalBonusEvent {
  final String driverId;
  LoadGoalBonus(this.driverId);
}

abstract class GoalBonusState {}

class GoalBonusInitial extends GoalBonusState {}

class GoalBonusLoading extends GoalBonusState {}

class GoalBonusLoaded extends GoalBonusState {
  final List<dynamic> bonuses;
  GoalBonusLoaded(this.bonuses);
}

class GoalBonusError extends GoalBonusState {
  final String message;
  GoalBonusError(this.message);
}

class GoalBonusBloc extends Bloc<GoalBonusEvent, GoalBonusState> {
  final GoalBonusRepository repository;

  GoalBonusBloc(this.repository) : super(GoalBonusInitial()) {
    on<LoadGoalBonus>((event, emit) async {
      emit(GoalBonusLoading());
      try {
        final data = await repository.fetchGoalBonus(event.driverId);
        emit(GoalBonusLoaded(data));
      } catch (e) {
        emit(GoalBonusError(e.toString()));
      }
    });
  }
}