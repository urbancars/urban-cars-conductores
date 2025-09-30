import 'package:equatable/equatable.dart';

abstract class PagosEvent extends Equatable {
  const PagosEvent();

  @override
  List<Object?> get props => [];
}

class FetchPagos extends PagosEvent {
  final String driverId;
  final bool forceRefresh; // ✅ new field

  const FetchPagos({
    required this.driverId,
    this.forceRefresh = false, // ✅ default value keeps old behavior
  });

  @override
  List<Object?> get props => [driverId, forceRefresh];
}
