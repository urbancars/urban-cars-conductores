import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/balance_repository.dart';
import 'balance_event.dart';
import 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceRepository repository;

  BalanceBloc(this.repository) : super(BalanceInitial()) {
    on<FetchBalance>((event, emit) async {
      emit(BalanceLoading());
      try {
        final balances = await repository.fetchBalance(event.driverId);
        emit(BalanceLoaded(balances));
      } catch (e) {
        emit(BalanceError(e.toString()));
      }
    });
  }
}