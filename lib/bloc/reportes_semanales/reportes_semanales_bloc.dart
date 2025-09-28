import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/reportes_semanales_repository.dart';

abstract class ReportesSemanalesEvent {}

class LoadReportesSemanales extends ReportesSemanalesEvent {
  final String driverId;
  LoadReportesSemanales(this.driverId);
}

abstract class ReportesSemanalesState {}

class ReportesSemanalesInitial extends ReportesSemanalesState {}

class ReportesSemanalesLoading extends ReportesSemanalesState {}

class ReportesSemanalesLoaded extends ReportesSemanalesState {
  final List<dynamic> reportes;
  ReportesSemanalesLoaded(this.reportes);
}

class ReportesSemanalesError extends ReportesSemanalesState {
  final String message;
  ReportesSemanalesError(this.message);
}

class ReportesSemanalesBloc extends Bloc<ReportesSemanalesEvent, ReportesSemanalesState> {
  final ReportesSemanalesRepository repository;

  ReportesSemanalesBloc(this.repository) : super(ReportesSemanalesInitial()) {
    on<LoadReportesSemanales>((event, emit) async {
      emit(ReportesSemanalesLoading());
      try {
        final data = await repository.fetchReportesSemanales(event.driverId);
        emit(ReportesSemanalesLoaded(data));
      } catch (e) {
        emit(ReportesSemanalesError(e.toString()));
      }
    });
  }
}