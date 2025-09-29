import '../models/balance.dart';
import '../services/api_service.dart';

class BalanceRepository {
  final ApiService api;

  BalanceRepository(this.api);

  Future<List<Balance>> fetchBalance(String driverId) async {
    final list = await api.getBalance(driverId);
    return list.map((e) => Balance.fromJson(e)).toList();
  }
}