import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object?> get props => [];
}

class FetchBalance extends BalanceEvent {
  final String driverId;

  const FetchBalance({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}