import 'package:flutter_bloc/flutter_bloc.dart';
import 'reportes_event.dart';
import 'reportes_state.dart';
import '../../data/repositories/reportes_repository.dart';

class ReportesBloc extends Bloc<ReportesEvent, ReportesState> {
  final ReportesRepository repository;

  ReportesBloc(this.repository) : super(ReportesInitial()) {
    on<LoadReportes>(_onLoadReportes);
  }

  Future<void> _onLoadReportes(
      LoadReportes event, Emitter<ReportesState> emit) async {
    emit(ReportesLoading());
    try {
      final data = await repository.fetchReportes(
        event.driverId,
        days: event.days,
      );
      emit(ReportesLoaded(data));
    } catch (e) {
      emit(ReportesError("Error al cargar reportes: $e"));
    }
  }
}