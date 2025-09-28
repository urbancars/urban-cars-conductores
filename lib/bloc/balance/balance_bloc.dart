import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/balance_repository.dart';

abstract class BalanceEvent {}

class LoadBalance extends BalanceEvent {
  final String driverId;
  LoadBalance(this.driverId);
}

abstract class BalanceState {}

class BalanceInitial extends BalanceState {}

class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final List<dynamic> balance;
  BalanceLoaded(this.balance);
}

class BalanceError extends BalanceState {
  final String message;
  BalanceError(this.message);
}

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceRepository repository;

  BalanceBloc(this.repository) : super(BalanceInitial()) {
    on<LoadBalance>((event, emit) async {
      emit(BalanceLoading());
      try {
        final data = await repository.fetchBalance(event.driverId);
        emit(BalanceLoaded(data));
      } catch (e) {
        emit(BalanceError(e.toString()));
      }
    });
  }
}