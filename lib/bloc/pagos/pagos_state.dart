import '../../data/models/pago.dart';

abstract class PagosState {}

class PagosInitial extends PagosState {}
class PagosLoading extends PagosState {}
class PagosLoaded extends PagosState {
  final List<Pago> pagos;
  PagosLoaded(this.pagos);
}
class PagosError extends PagosState {
  final String message;
  PagosError(this.message);
}