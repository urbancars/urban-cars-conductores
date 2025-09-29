import '../../data/models/reporte_semanal.dart';

abstract class ReporteSemanalState {}

class ReporteSemanalInitial extends ReporteSemanalState {}
class ReporteSemanalLoading extends ReporteSemanalState {}
class ReporteSemanalLoaded extends ReporteSemanalState {
  final List<ReporteSemanal> reportes;
  ReporteSemanalLoaded(this.reportes);
}
class ReporteSemanalError extends ReporteSemanalState {
  final String message;
  ReporteSemanalError(this.message);
}