abstract class PagosEvent {}

class FetchPagos extends PagosEvent {
  final int driverId;
  FetchPagos(this.driverId);
}