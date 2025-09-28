import '../services/api_service.dart';

class PagosRepository {
  final ApiService api;

  PagosRepository(this.api);

  Future<List<dynamic>> fetchPagos(String driverId) async {
    return await api.fetchData('pagos', driverId);
  }
}