import '../models/pago.dart';
import '../services/api_service.dart';

class PagosRepository {
  final ApiService api;

  PagosRepository(this.api);

  Future<List<Pago>> fetchPagos(String driverId) async {
    try {
      final list = await api.getPagos(driverId);

      return list.map((e) {
        try {
          return Pago.fromJson(e);
        } catch (err) {
          throw Exception("Error al parsear un pago: $e");
        }
      }).toList();
    } catch (e) {
      throw Exception("No se pudieron cargar los pagos: $e");
    }
  }
}
