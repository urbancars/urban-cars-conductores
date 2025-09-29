import 'package:equatable/equatable.dart';

abstract class ReportesEvent extends Equatable {
  const ReportesEvent();

  @override
  List<Object?> get props => [];
}

class LoadReportes extends ReportesEvent {
  final int driverId;
  final int days;

  const LoadReportes({required this.driverId, this.days = 14});

  @override
  List<Object?> get props => [driverId, days];
}