import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/goal_bonus_repository.dart';
import 'goal_bonus_event.dart';
import 'goal_bonus_state.dart';

class GoalBonusBloc extends Bloc<GoalBonusEvent, GoalBonusState> {
  final GoalBonusRepository repository;

  GoalBonusBloc(this.repository) : super(GoalBonusInitial()) {
    on<FetchGoalBonus>((event, emit) async {
      emit(GoalBonusLoading());
      try {
        final bonuses = await repository.fetchGoalBonus(event.driverId);
        emit(GoalBonusLoaded(bonuses));
      } catch (e) {
        emit(GoalBonusError(e.toString()));
      }
    });
  }
}