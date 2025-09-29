import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/pagos_repository.dart';
import 'pagos_event.dart';
import 'pagos_state.dart';

class PagosBloc extends Bloc<PagosEvent, PagosState> {
  final PagosRepository repository;

  PagosBloc(this.repository) : super(PagosInitial()) {
    on<FetchPagos>((event, emit) async {
      emit(PagosLoading());
      try {
        final pagos = await repository.fetchPagos(event.driverId);
        emit(PagosLoaded(pagos));
      } catch (e) {
        emit(PagosError(e.toString()));
      }
    });
  }
}