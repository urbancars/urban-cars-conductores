import 'package:equatable/equatable.dart';

abstract class ReportesEvent extends Equatable {
  const ReportesEvent();

  @override
  List<Object?> get props => [];
}

class FetchReportes extends ReportesEvent {
  final String driverId;
  final bool forceRefresh;

  const FetchReportes({required this.driverId, this.forceRefresh = false});

  @override
  List<Object?> get props => [driverId, forceRefresh];
}
