abstract class BalanceEvent {}

class FetchBalance extends BalanceEvent {
  final int driverId;
  FetchBalance(this.driverId);
}