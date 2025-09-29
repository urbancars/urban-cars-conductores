import 'package:flutter_bloc/flutter_bloc.dart';
import 'reportes_event.dart';
import 'reportes_state.dart';
import '../../data/repositories/reportes_repository.dart';

class ReportesBloc extends Bloc<ReportesEvent, ReportesState> {
  final ReportesRepository repository;

  ReportesBloc(this.repository) : super(ReportesInitial()) {
    on<FetchReportes>(_onFetchReportes);
  }

  Future<void> _onFetchReportes(
      FetchReportes event, Emitter<ReportesState> emit) async {
    emit(ReportesLoading());
    try {
      final reportes =
          await repository.fetchReportes(event.driverId, days: event.days);
      emit(ReportesLoaded(reportes));
    } catch (e) {
      emit(ReportesError(e.toString()));
    }
  }
}