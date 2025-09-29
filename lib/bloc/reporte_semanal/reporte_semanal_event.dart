import 'package:equatable/equatable.dart';

abstract class ReporteSemanalEvent extends Equatable {
  const ReporteSemanalEvent();

  @override
  List<Object?> get props => [];
}

class FetchReporteSemanal extends ReporteSemanalEvent {
  final String driverId;

  const FetchReporteSemanal({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}