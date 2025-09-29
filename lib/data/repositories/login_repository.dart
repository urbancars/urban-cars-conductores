import '../models/driver.dart';
import '../services/api_service.dart';

class LoginRepository {
  final ApiService api;

  LoginRepository(this.api);

  /// Logs in a driver by documento
  Future<Driver> login({required String documento}) async {
    final data = await api.getDriver(documento);

    if (data.isEmpty) {
      throw Exception("Conductor no encontrado");
    }

    return Driver.fromJson(data);
  }
}