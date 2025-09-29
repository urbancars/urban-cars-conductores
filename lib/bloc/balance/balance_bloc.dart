import 'package:flutter_bloc/flutter_bloc.dart';
import 'balance_event.dart';
import 'balance_state.dart';
import '../../data/repositories/balance_repository.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceRepository repository;

  BalanceBloc(this.repository) : super(BalanceInitial()) {
    on<FetchBalance>(_onFetchBalance);
  }

  Future<void> _onFetchBalance(
    FetchBalance event,
    Emitter<BalanceState> emit,
  ) async {
    emit(BalanceLoading());
    try {
      final balance = await repository.fetchBalance(event.driverId);
      emit(BalanceLoaded(balance));
    } catch (e) {
      emit(BalanceError(e.toString()));
    }
  }
}