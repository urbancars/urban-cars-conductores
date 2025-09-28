import 'package:equatable/equatable.dart';

abstract class ReportesEvent extends Equatable {
  const ReportesEvent();

  @override
  List<Object?> get props => [];
}

class LoadReportes extends ReportesEvent {
  final String driverId;
  final int days;

  const LoadReportes(this.driverId, this.days);

  @override
  List<Object?> get props => [driverId, days];
}