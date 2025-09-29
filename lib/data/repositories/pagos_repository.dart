import '../models/pago.dart';
import '../services/api_service.dart';

class PagosRepository {
  final ApiService api;

  PagosRepository(this.api);

  Future<List<Pago>> fetchPagos(int driverId) async {
    final list = await api.getPagos(driverId.toString());
    return list.map((e) => Pago.fromJson(e)).toList();
  }
}