import '../services/api_service.dart';

class BalanceRepository {
  final ApiService api;

  BalanceRepository(this.api);

  Future<List<dynamic>> fetchBalance(String driverId) async {
    return await api.fetchData('balance', driverId);
  }
}