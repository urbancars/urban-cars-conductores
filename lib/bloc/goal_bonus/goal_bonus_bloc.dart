import 'package:flutter_bloc/flutter_bloc.dart';
import 'goal_bonus_event.dart';
import 'goal_bonus_state.dart';
import '../../data/repositories/goal_bonus_repository.dart';

class GoalBonusBloc extends Bloc<GoalBonusEvent, GoalBonusState> {
  final GoalBonusRepository repository;

  GoalBonusBloc(this.repository) : super(GoalBonusInitial()) {
    on<FetchGoalBonus>(_onFetchGoalBonus);
  }

  Future<void> _onFetchGoalBonus(
    FetchGoalBonus event,
    Emitter<GoalBonusState> emit,
  ) async {
    emit(GoalBonusLoading());
    try {
      final bonuses = await repository.fetchGoalBonus(
        event.driverId,
        forceRefresh: event.forceRefresh, // ✅ allow bypassing cache
      );
      emit(GoalBonusLoaded(bonuses));
    } catch (e) {
      emit(GoalBonusError(e.toString()));
    }
  }
}
