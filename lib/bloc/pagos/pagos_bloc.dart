import 'package:flutter_bloc/flutter_bloc.dart';
import 'pagos_event.dart';
import 'pagos_state.dart';
import '../../data/repositories/pagos_repository.dart';

class PagosBloc extends Bloc<PagosEvent, PagosState> {
  final PagosRepository repository;

  PagosBloc(this.repository) : super(PagosInitial()) {
    on<FetchPagos>(_onFetchPagos);
  }

  Future<void> _onFetchPagos(
    FetchPagos event,
    Emitter<PagosState> emit,
  ) async {
    emit(PagosLoading());
    try {
      final pagos = await repository.fetchPagos(event.driverId);
      emit(PagosLoaded(pagos));
    } catch (e) {
      emit(PagosError(e.toString()));
    }
  }
}
