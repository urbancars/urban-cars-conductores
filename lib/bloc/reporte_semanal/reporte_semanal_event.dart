abstract class ReporteSemanalEvent {}

class FetchReporteSemanal extends ReporteSemanalEvent {
  final int driverId;
  FetchReporteSemanal(this.driverId);
}