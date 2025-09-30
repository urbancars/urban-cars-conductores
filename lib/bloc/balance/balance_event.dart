import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object?> get props => [];
}

class FetchBalance extends BalanceEvent {
  final String driverId;
  final bool forceRefresh;

  const FetchBalance({required this.driverId, this.forceRefresh = false});

  @override
  List<Object?> get props => [driverId, forceRefresh];
}
