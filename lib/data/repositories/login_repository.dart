import '../models/driver.dart';
import '../services/api_service.dart';

class LoginRepository {
  final ApiService api;

  LoginRepository(this.api);

  Future<Driver> login(String documento) async {
    try {
      final driverMap = await api.getDriver(documento);
      return Driver.fromJson(driverMap);
    } catch (e) {
      // strip out Dart's "Exception: " prefix and keep only the message
      final msg = e.toString().replaceFirst("Exception: ", "");
      throw Exception(msg); // will display just "Documento no encontrado"
    }
  }
}
