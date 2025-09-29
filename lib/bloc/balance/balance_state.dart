import '../../data/models/balance.dart';

abstract class BalanceState {}

class BalanceInitial extends BalanceState {}
class BalanceLoading extends BalanceState {}
class BalanceLoaded extends BalanceState {
  final List<Balance> balances;
  BalanceLoaded(this.balances);
}
class BalanceError extends BalanceState {
  final String message;
  BalanceError(this.message);
}