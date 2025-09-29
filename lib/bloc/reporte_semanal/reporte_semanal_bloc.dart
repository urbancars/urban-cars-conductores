import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/reporte_semanal_repository.dart';
import 'reporte_semanal_event.dart';
import 'reporte_semanal_state.dart';

class ReporteSemanalBloc extends Bloc<ReporteSemanalEvent, ReporteSemanalState> {
  final ReporteSemanalRepository repository;

  ReporteSemanalBloc(this.repository) : super(ReporteSemanalInitial()) {
    on<FetchReporteSemanal>((event, emit) async {
      emit(ReporteSemanalLoading());
      try {
        final reportes = await repository.fetchReporteSemanal(event.driverId);
        emit(ReporteSemanalLoaded(reportes));
      } catch (e) {
        emit(ReporteSemanalError(e.toString()));
      }
    });
  }
}