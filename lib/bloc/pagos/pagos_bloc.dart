import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/pagos_repository.dart';

abstract class PagosEvent {}


class LoadPagos extends PagosEvent {
  final String driverId;
  LoadPagos(this.driverId);
}
abstract class PagosState {}

class PagosInitial extends PagosState {}

class PagosLoading extends PagosState {}

class PagosLoaded extends PagosState {
  final List<dynamic> pagos;
  PagosLoaded(this.pagos);
}

class PagosError extends PagosState {
  final String message;
  PagosError(this.message);
}

class PagosBloc extends Bloc<PagosEvent, PagosState> {
  final PagosRepository repository;

  PagosBloc(this.repository) : super(PagosInitial()) {
    on<LoadPagos>((event, emit) async {
      emit(PagosLoading());
      try {
        final data = await repository.fetchPagos(event.driverId);
        emit(PagosLoaded(data));
      } catch (e) {
        emit(PagosError(e.toString()));
      }
    });
  }
}