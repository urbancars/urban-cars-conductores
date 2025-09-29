import 'package:equatable/equatable.dart';

abstract class ReportesEvent extends Equatable {
  const ReportesEvent();

  @override
  List<Object?> get props => [];
}

class FetchReportes extends ReportesEvent {
  final String driverId;
  final int days;

  const FetchReportes({required this.driverId, this.days = 14});

  @override
  List<Object?> get props => [driverId, days];
}