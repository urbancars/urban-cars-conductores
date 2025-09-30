import 'package:equatable/equatable.dart';

abstract class ReporteSemanalEvent extends Equatable {
  const ReporteSemanalEvent();

  @override
  List<Object?> get props => [];
}

class FetchReporteSemanal extends ReporteSemanalEvent {
  final String driverId;
  final bool forceRefresh;

  const FetchReporteSemanal({
    required this.driverId,
    this.forceRefresh = false, // ✅ default = false
  });

  @override
  List<Object?> get props => [driverId, forceRefresh];
}
