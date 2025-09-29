import 'package:equatable/equatable.dart';
import '../../data/models/reporte_semanal.dart';

abstract class ReporteSemanalState extends Equatable {
  const ReporteSemanalState();

  @override
  List<Object?> get props => [];
}

class ReporteSemanalInitial extends ReporteSemanalState {}

class ReporteSemanalLoading extends ReporteSemanalState {}

class ReporteSemanalLoaded extends ReporteSemanalState {
  final List<ReporteSemanal> reportes;

  const ReporteSemanalLoaded(this.reportes);

  @override
  List<Object?> get props => [reportes];
}

class ReporteSemanalError extends ReporteSemanalState {
  final String message;

  const ReporteSemanalError(this.message);

  @override
  List<Object?> get props => [message];
}