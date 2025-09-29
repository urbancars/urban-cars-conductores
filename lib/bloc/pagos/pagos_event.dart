import 'package:equatable/equatable.dart';

abstract class PagosEvent extends Equatable {
  const PagosEvent();

  @override
  List<Object?> get props => [];
}

class FetchPagos extends PagosEvent {
  final String driverId;

  const FetchPagos({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}